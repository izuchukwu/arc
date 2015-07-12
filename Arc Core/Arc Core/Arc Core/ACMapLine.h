//
//  ACMapLine.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACMapLine : NSObject

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) NSMutableArray *points; //points on its path
@property (nonatomic, assign) CGPoint available;

// For Map Use

@property (nonatomic, assign) CGVector vector;
@property (nonatomic, assign) CGVector turnVectorIndex;
@property (nonatomic, assign) CGVector turnTendency;

@end