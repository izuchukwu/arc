//
//  ACMapNodeRiver.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMapNodeRiver.h"

@interface ACMapNodeRiver ()

@property (nonatomic, strong) NSString *status;

@end

@implementation ACMapNodeRiver

- (NSString *)nodeTitle {
    return @"River";
}

- (NSString *)nodeChar {
    return @" ";
}

- (NSString *)status {
    return [NSString stringWithFormat:@"%@%@%@", self.nodeTitle, (_status ? [NSString stringWithFormat:@"\n%@", _status] : @""), (self.state ? [NSString stringWithFormat:@"\n%@", self.state.name] : @"Free Territory")];
}

@end
