//
//  ACMapNodeGrasslands.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMapNodeGrasslands.h"

@interface ACMapNodeGrasslands ()

@property (nonatomic, strong) NSString *status;

@end

@implementation ACMapNodeGrasslands

- (NSString *)nodeTitle {
    return @"Grasslands";
}

- (NSString *)nodeChar {
    return @"g";
}

- (NSString *)status {
    return [NSString stringWithFormat:@"%@%@%@", self.nodeTitle, (_status ? [NSString stringWithFormat:@"\n%@", _status] : @""), (self.state ? [NSString stringWithFormat:@"\n%@", self.state.name] : @"Free Territory")];
}

@end
