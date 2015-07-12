//
//  ACInterface.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACInterface.h"

// interface - action buffer

@interface ACInterface ()

@end

@implementation ACInterface

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

// For Arc

- (void)arcDidUpdateWithDelta:(ACArcDelta *)arcDelta {
    [self.delegate arcDidUpdateWithDelta:arcDelta];
}

@end
