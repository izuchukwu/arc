//
//  ACMapNode.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMapNode.h"

@interface ACMapNode ()

@property (nonatomic, copy) NSMutableArray *components;

@end

@implementation ACMapNode

- (instancetype)initWithComponents:(NSArray *)components {
    self = [super init];
    if (self) {
        self.components = [NSMutableArray arrayWithArray:components];
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
    return nil;
}

@end
