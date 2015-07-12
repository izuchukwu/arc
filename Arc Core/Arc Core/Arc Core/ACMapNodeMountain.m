//
//  ACMapNodeMountain.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMapNodeMountain.h"

@interface ACMapNodeMountain ()

@property (nonatomic, strong) NSString *status;

@end

@implementation ACMapNodeMountain

- (NSString *)nodeTitle {
    return @"Mountain";
}

- (NSString *)nodeChar {
    return @"m";
}

- (NSString *)status {
    return [NSString stringWithFormat:@"%@%@%@", self.nodeTitle, (_status ? [NSString stringWithFormat:@"\n%@", _status] : @""), (self.state ? [NSString stringWithFormat:@"\n%@", self.state.name] : @"Free Territory")];
}

@end
