//
//  ACMapNodeForest.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMapNodeForest.h"

@interface ACMapNodeForest ()

@property (nonatomic, strong) NSString *status;

@end

@implementation ACMapNodeForest

- (NSString *)nodeTitle {
    return @"Forest";
}

- (NSString *)nodeChar {
    return @"f";
}

- (NSString *)status {
    return [NSString stringWithFormat:@"%@%@%@", self.nodeTitle, (_status ? [NSString stringWithFormat:@"\n%@", _status] : @""), (self.state ? [NSString stringWithFormat:@"\n%@", self.state.name] : @"Free Territory")];
}

@end
