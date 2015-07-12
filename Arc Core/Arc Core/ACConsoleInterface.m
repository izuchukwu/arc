//
//  ACConsoleInterface.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACConsoleInterface.h"

#import "ACConsole.h"
#import "ACConsoleData.h"

@interface ACConsoleInterface ()

@property (nonatomic, strong) ACArc *arc;
@property (nonatomic, strong) ACInterface *interface;

@property (nonatomic, assign) ACMapNode *selectedNode;
@property (nonatomic, assign) BOOL noSelection;

@end

@implementation ACConsoleInterface

+ (ACConsoleInterface *)standardInterface {
    return [[ACConsoleInterface alloc] init];
}

- (void)start {
    ACConsoleData *groundCData = [[ACConsoleData alloc] init];
    [groundCData setTitle:@"Arc: handcraft civilization."];
    [groundCData setShouldRead:YES];
    [groundCData setPrompt:@"Name your ground."];
    
    NSString *groundName = [ACConsole inputForConsoleData:groundCData openEnded:YES];
    
    self.noSelection = YES;
    
    self.arc = [[ACArc alloc] initWithName:groundName interfaceDelegate:self];
    self.interface = self.arc.interface;
}

#pragma mark - Interface Delegate

- (void)arcDidUpdateWithDelta:(ACArcDelta *)arcDelta {
    if ([arcDelta transformation] == ACArcDeltaMapNodeTransformationGen) {
        if (self.noSelection) {
            self.selectedNode = [arcDelta.state origin];
        }
        
        ACConsoleData *genCData = [[ACConsoleData alloc] init];
        [genCData setTitle:@"Your world awaits."];
        [genCData setMap:[self printState:arcDelta.state]];
        [genCData setStatus:[NSString stringWithFormat:@"%@%@", arcDelta.node.status, (arcDelta.status ? [NSString stringWithFormat:@"\n\n%@", arcDelta.status] : @"")]];
        [ACConsole inputForConsoleData:genCData openEnded:YES];
    }
}

#pragma mark - Map I/O

- (NSString *)printState:(ACState *)state {
    NSString *mapStr = @"";
    NSMutableDictionary *nodes = [[NSMutableDictionary alloc] init];
    
    nodes[k(uv(state.origin.vector))] = state.origin;
    [self traverseLineFromNode:state.origin toMap:nodes fromWorkingPoint:uv(state.origin.vector)];
    
    int minx = 0, miny = 0, maxx = 0, maxy = 0;
    int w = 0, h = 0;
    
    for (NSString *ptstr in nodes) {
        CGPoint pt = p(ptstr);
        if (minx > pt.x) minx = pt.x;
        if (miny > pt.y) miny = pt.y;
        if (maxx < pt.x) maxx = pt.x;
        if (maxy < pt.x) maxy = pt.y;
    }
    
    w = maxx - minx;
    h = maxy - miny;
    
    for (int x = minx; x < w; x++) {
        mapStr = [mapStr stringByAppendingString:@"-"];
    }
    mapStr = [mapStr stringByAppendingString:@"\n"];
    
    for (int y = miny; y < h; y++) {
        for (int x = minx; x < w; x++) {
            NSString *hereKey = k(m(x,y));
            
            if (nodes[hereKey]) {
                if (nodes[hereKey] == self.selectedNode) {
                    mapStr = [mapStr stringByAppendingString:@"x"];
                } else {
                    mapStr = [mapStr stringByAppendingString:[nodes[hereKey] nodeChar]];
                }
            } else {
                mapStr = [mapStr stringByAppendingString:@" "];
            }
        }
        mapStr = [mapStr stringByAppendingString:@"\n"];
    }
    
    for (int x = minx; x < w; x++) {
        mapStr = [mapStr stringByAppendingString:@"-"];
    }
    
    return mapStr;
}

- (void)traverseLineFromNode:(ACMapNode *)workingNode toMap:(NSMutableDictionary *)nodes fromWorkingPoint:(CGPoint)workingPoint {
    for (ACMapNode *node in [workingNode connectedNodes]) {
        CGPoint loc = m(workingPoint.x + node.vector.dx, workingPoint.y + node.vector.dy);
        nodes[k(loc)] = node;
        [self traverseLineFromNode:node toMap:nodes fromWorkingPoint:loc];
    }
}

@end
