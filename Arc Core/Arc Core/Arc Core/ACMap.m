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
@property (nonatomic, strong) NSMutableDictionary *origins;
@property (nonatomic, strong) NSMutableArray *heatMap;

@end

@implementation ACMap

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.origins = [[NSMutableDictionary alloc] init];
        self.heatMap = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - genesis

- (void)genesisWithState:(ACState *)state {
    [self originateWithPlayerState:state];
}

#pragma mark - Map Terraform

- (void)originateWithPlayerState:(ACState *)state {
    [self originateWithPlayerState:state fromPoint:CGPointZero];
}

- (void)originateWithPlayerState:(ACState *)state fromPoint:(CGPoint)point {
    self.origins[state.name] = [[ACMapNodeGrasslands alloc] init];
    NSArray *adjacents = [self adjacentPointsToPoint:point];
    for (NSString *strpt in adjacents) {
        CGPoint pt = NSPointToCGPoint(NSPointFromString(strpt));
        ACMapNode *node = [self terraform];
        [node setVector:tv(pt)];
        [[self.origins[state.name] connectedNodes] addObject:node];
        [self.heatMap addObject:strpt];
    }
    
    [self.origins[state.name] setState:state];
    [state setOrigin:self.origins[state.name]];
}

- (ACMapNode *)terraform {
    int chance = arc4random_uniform(10);
    if (chance > 9) {
        // 10% chance for mtn
        return [[ACMapNodeMountain alloc] init];
    } else if (chance > 7) {
        // 20% chance for forest
        return [[ACMapNodeForest alloc] init];
    } else {
        // 70% chance for grasslands
        return [[ACMapNodeGrasslands alloc] init];
    }
}

#pragma mark - Map Geometry

- (NSArray *)adjacentPointsToPoint:(CGPoint)point {
    NSMutableArray *adjacents = [[NSMutableArray alloc] init];
    
    for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
            if (dx == 0 && dy == 0) {
                continue;
            }
            [adjacents addObject:NSStringFromPoint(NSPointFromCGPoint(m(point.x + dx, point.y +dy)))];
        }
    }
    
    return adjacents;
}

@end
