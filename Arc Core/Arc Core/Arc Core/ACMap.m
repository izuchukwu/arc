//
//  ACMap.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMap.h"
#import "ACMapNode.h"

#import "ACMapNodeGrasslands.h"
#import "ACMapNodeForest.h"
#import "ACMapNodeRiver.h"
#import "ACMapNodeMountain.h"

@interface ACMap ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableDictionary *map;

@end

@implementation ACMap

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.map = [[NSMutableDictionary alloc] init];
        
        _width = ww;
        _height = hh;
    }
    return self;
}

#pragma mark - genesis

- (void)genesis {
    [self terraform];
}

- (void)postGenesisForPlayerState:(ACState *)state {
    CGPoint start = [self startingPointFromCenter];
    [self setNode:[[ACMapNodeGrasslands alloc] init] atPoint:start];
    [[self nodeAtPoint:start] setState:state];
    [[state nodes] addObject:[self nodeAtPoint:start]];
    
    //linegen
    
    
}

#pragma mark - State Positioning

- (CGPoint)startingPointFromCenter {
    CGPoint center = m(ceil(self.width / 2), ceil(self.height / 2));
    return [self startingPointFromPoint:center];
}

- (CGPoint)startingPointFromPoint:(CGPoint)point {
    if ([[self nodeAtPoint:point] isKindOfClass:[ACMapNodeRiver class]]) {
        NSArray *nodes = [self adjacentNodesToNode:[self nodeAtPoint:point]];
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (ACMapNode *node in nodes) {
            [points addObject:NSStringFromPoint(NSPointFromCGPoint([self pointForNode:node]))];
        }
        int nextPoint = arc4random_uniform((u_int32_t)[nodes count]);
        return [self startingPointFromPoint:NSPointToCGPoint(NSPointFromString(points[nextPoint]))];
    } else {
        return point;
    }
}

#pragma mark - Map Terraform

- (void)terraform {
    [self landgen];
    [self rivergen];
    [self rivergen];
    [self mountaingen];
    
    [self.delegate mapDidCompleteGen];
}

- (void)landgen {
    for (int x = 0; x < self.width; x++) {
        for (int y = 0; y < self.height; y++) {
            int chance = arc4random_uniform(10);
            [self setNode:[[ACMapNodeGrasslands alloc] init] atPoint:m(x, y)];
            if (chance > 5) {
                // 40% chance for forest
                [self setNode:[[ACMapNodeForest alloc] init] atPoint:m(x, y)];
            }
        }
    }
}

- (void)rivergen {
    //get startpoint
    int startside = arc4random_uniform(4); //l,t,r,b
    CGPoint startpoint;
    CGVector turnVector;
    
    NSArray *turnVectors = @[@"{0,-1}", @"{1,-1}", @"{1,0}", @"{1,1}", @"{0,1}", @"{-1,1}", @"{-1,0}", @"{-1,-1}"];
    int turnVectorIndex = 0;
    
    if (startside == 0 || startside == 2) {
        // left or right
        startpoint.y = arc4random_uniform(self.height - 2) + 1;
        startpoint.x = startside == 0 ? 0 : self.width - 1;
    } else {
        // top or bottom
        startpoint.x = arc4random_uniform(self.width - 2) + 1;
        startpoint.y = startside == 1 ? 0 : self.height - 1;
    }
    
    turnVectorIndex = ((startside * 2) + 2) % 8;
    //NSLog(@"startside %d, initialturnvectorindex %d", startside, turnVectorIndex);
    CGPoint ptVctr = NSPointToCGPoint(NSPointFromString(turnVectors[turnVectorIndex]));
    turnVector.dx = ptVctr.x;
    turnVector.dy = ptVctr.y;
    
    int turnTendency = 3; // 0-3; 3 high, 0 low -> tendency for vector to change
    int lastTurn = 0;
    BOOL collision = NO;
    CGPoint here = startpoint;
    NSMutableArray *riverPath = [[NSMutableArray alloc] init];
    int i = 0;
    
    while (!collision) {
        ACMapNode *node = [self nodeAtPoint:here];
        if (!node || [node isKindOfClass:[ACMapNodeRiver class]]) {
            [riverPath addObject:[NSString stringWithFormat:@"collision at %@", NSStringFromPoint(NSPointFromCGPoint(here))]];
            collision = YES;
            continue;
        }
        
        [self setNode:[[ACMapNodeRiver alloc] init] atPoint:here];
        [riverPath addObject:[NSString stringWithFormat:@"%d %@", i, NSStringFromPoint(NSPointFromCGPoint(here))]];
        i++;
        
        if ((lastTurn >= 2 && (arc4random_uniform(100) < ((turnTendency * 25) + 25))) || lastTurn >= 6) {
            lastTurn = 0;
            
            int nextTurnOffset = arc4random_uniform(3) - 1;
            turnVectorIndex = (turnVectorIndex + nextTurnOffset) % 8;
            if (turnVectorIndex < 0) turnVectorIndex = 8 + turnVectorIndex;
            
            CGPoint ptVctr = NSPointToCGPoint(NSPointFromString(turnVectors[turnVectorIndex]));
            turnVector.dx = ptVctr.x;
            turnVector.dy = ptVctr.y;
            
            turnTendency = arc4random_uniform(4);
            [riverPath addObject:[NSString stringWithFormat:@"didturn, tendency %d, newturnvectorindex %d", turnTendency, turnVectorIndex]];
        } else {
            lastTurn++;
        }
        
        CGPoint nextPoint = CGPointMake(here.x + turnVector.dx, here.y + turnVector.dy);
        here = nextPoint;
    }
    
    //NSLog(@"rivergen:\n %@", riverPath);
}

- (void)mountaingen {
    for (int x = 0; x < self.width; x++) {
        for (int y = 0; y < self.height; y++) {
            int chance = arc4random_uniform(100);
            if (chance > 94) {
                // low chance for mtn, avoid rivers
                if (![[self nodeAtPoint:m(x, y)] isKindOfClass:[ACMapNodeRiver class]]) {
                    [self setNode:[[ACMapNodeMountain alloc] init] atPoint:m(x, y)];
                }
            }
        }
    }
}

#pragma mark - Map Geometry

- (NSArray *)adjacentNodesToNode:(ACMapNode *)node {
    NSMutableArray *adjacents = [[NSMutableArray alloc] init];
    
    CGPoint point = [self pointForNode:node];
    
    for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
            if (dx == point.x && dy == point.y) {
                continue;
            }
            
            if (point.x + dx < 0 || point.y + dy < 0) {
                continue;
            }
            
            ACMapNode *node = [self nodeAtPoint:m(point.x + dx, point.y + dy)];
            
            if (node) {
                [adjacents addObject:node];
            }
        }
    }
    return adjacents;
}
             
#pragma mark - Map Store

- (CGPoint)pointForNode:(ACMapNode *)node {
    for (NSString *pointStr in self.map) {
        ACMapNode *thisNode = self.map[pointStr];
        
        if (thisNode == node) {
            return NSPointToCGPoint(NSPointFromString(pointStr));
        }
    }
    return CGPointZero;
}

- (ACMapNode *)nodeAtPoint:(CGPoint)point {
    return self.map[NSStringFromPoint(NSPointFromCGPoint(point))];
}
             
- (void)setNode:(ACMapNode *)node atPoint:(CGPoint)point {
    NSString *key = NSStringFromPoint(NSPointFromCGPoint(point));
    self.map[key] = node;
}

@end
