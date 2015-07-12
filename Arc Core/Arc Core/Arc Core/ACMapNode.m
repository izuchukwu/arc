//
//  ACMapNode.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMapNode.h"

@interface ACMapNode ()

@property (nonatomic, strong) NSMutableArray *components;
@property (nonatomic, strong) NSString *status;

@end

@implementation ACMapNode

- (instancetype)init{
    self = [super init];
    if (self) {
        self.components = [[NSMutableArray alloc] init];
        self.connectedNodes = [[NSMutableArray alloc] init];
        self.lines = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addComponent:(id<ACMapNodeComponent>)component {
    [self.components addObject:component];
}

- (NSString *)nodeTitle {
    return @"Unassigned Node";
}

- (NSString *)nodeChar {
    return @"u";
}

- (NSString *)status {
    return [NSString stringWithFormat:@"%@%@%@", self.nodeTitle, (_status ? [NSString stringWithFormat:@"\n%@", _status] : @""), (self.state ? [NSString stringWithFormat:@"\n%@", self.state.name] : @"Free Territory")];
}

@end
