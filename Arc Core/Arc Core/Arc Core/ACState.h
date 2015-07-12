//
//  ACState.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACState : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong) NSMutableArray *nodes;

- (instancetype)initWithName:(NSString *)name;
- (NSArray *)scopedPoints;

// For Map Use

@property (nonatomic, strong) NSMutableArray *lines; // arr of @[vector, endnode]

@end
