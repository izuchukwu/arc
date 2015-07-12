//
//  ACState.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACState.h"

@implementation ACState

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        
        self.nodes = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
