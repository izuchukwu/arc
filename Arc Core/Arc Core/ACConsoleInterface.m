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

@property (nonatomic, assign) CGPoint selectedPoint;
@property (nonatomic, assign) BOOL noPointSelected;

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
    
    self.noPointSelected = YES;
    
    self.arc = [[ACArc alloc] initWithName:groundName interfaceDelegate:self];
    self.interface = self.arc.interface;
}

#pragma mark - Interface Delegate

- (void)arcDidUpdateWithDelta:(ACArcDelta *)arcDelta {
    if ([arcDelta transformation] == ACArcDeltaMapNodeTransformationGen) {
        if (self.noPointSelected) {
            self.selectedPoint = [arcDelta.map pointForNode:[arcDelta.state nodes][0]];
        }
        
        ACConsoleData *genCData = [[ACConsoleData alloc] init];
        [genCData setTitle:@"Your world awaits."];
        [genCData setMap:[self printMap:arcDelta.map scoped:YES]];
        [ACConsole inputForConsoleData:genCData openEnded:YES];
    }
}

#pragma mark - Map I/O

- (NSString *)printMap:(ACMap *)map scoped:(BOOL)scoped {
    NSString *mapStr = @"";
    
    for (int x = 0; x < map.width; x++) {
        mapStr = [mapStr stringByAppendingString:@"-"];
    }
    mapStr = [mapStr stringByAppendingString:@"\n"];
    
    for (int y = 0; y < map.height; y++) {
        for (int x = 0; x < map.width; x++) {
            if (!CGPointEqualToPoint(self.selectedPoint, m(x,y))) {
                mapStr = [mapStr stringByAppendingString:[[map nodeAtPoint:m(x, y)] nodeChar]];
            } else {
                mapStr = [mapStr stringByAppendingString:@"x"];
            }
        }
        mapStr = [mapStr stringByAppendingString:@"\n"];
    }
    
    for (int x = 0; x < map.width; x++) {
        mapStr = [mapStr stringByAppendingString:@"-"];
    }
    
    return mapStr;
}

@end
