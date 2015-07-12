//
//  ACMapLine.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACMapLine : NSObject

@property (nonatomic, assign) CGVector vector;
@property (nonatomic, assign) int turnVectorIndex;
@property (nonatomic, assign) int turnTendency;

@property (nonatomic, assign) CGPoint nextPoint;

+ (NSArray *)turnVectors;

@end