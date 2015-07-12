//
//  ACState.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACMapNode.h"

@class ACMapNode;

@interface ACState : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong) ACMapNode *origin;

- (instancetype)initWithName:(NSString *)name;

// For Map Use

@property (nonatomic, strong) NSMutableArray *lines; // arr of @[vector, endnode]

@end
