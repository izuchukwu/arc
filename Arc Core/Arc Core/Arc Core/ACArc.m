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
        [self.map genesis];
    }
    return self;
}

#pragma mark - Map Delegate

- (void)mapDidCompleteGen {
    ACState *playerState = self.states[0];
    [self.map postGenesisForPlayerState:playerState];
    
    ACArcDelta *delta = [[ACArcDelta alloc] init];
    [delta setMap:self.map];
    [delta setTransformation:ACArcDeltaMapNodeTransformationGen];
    [delta setState:playerState];
    [delta setNode:playerState.nodes[0]];
    [self.interface arcDidUpdateWithDelta:delta];
}

@end
