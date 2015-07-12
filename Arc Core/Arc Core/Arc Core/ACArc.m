//
//  ACArc.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACArc.h"
#import "ACState.h"

@interface ACArc ()

@property (nonatomic, strong) ACMap *map;
@property (nonatomic, strong) NSMutableArray *states;

@end

@implementation ACArc

- (instancetype)initWithName:(NSString *)name interfaceDelegate:(id<ACInterfaceDelegate>)interfaceDelegate {
    self = [super init];
    if (self) {
        self.interface = [[ACInterface alloc] initWithName:name];
        [self.interface setDelegate:interfaceDelegate];
        
        self.states = [[NSMutableArray alloc] init];
        [self.states addObject:[[ACState alloc] initWithName:name]];
        
        self.map = [[ACMap alloc] initWithName:name];
        [self.map setDelegate:self];
        for (ACState *state in self.states) {
            [self.map genesisWithState:state];
        }
        
        ACState *playerState = self.states[0];
        ACArcDelta *delta = [[ACArcDelta alloc] init];
        [delta setMap:self.map];
        [delta setTransformation:ACArcDeltaMapNodeTransformationGen];
        [delta setState:playerState];
        [delta setNode:playerState.origin];
        [self.interface arcDidUpdateWithDelta:delta];
    }
    return self;
}

@end
