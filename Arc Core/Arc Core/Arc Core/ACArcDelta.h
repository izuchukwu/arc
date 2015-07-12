//
//  ACArcDelta.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACMap.h"
#import "ACMapNode.h"

@class ACMap;

@interface ACArcDelta : NSObject

typedef NS_ENUM(NSInteger, ACArcDeltaMapNodeTransformation){
    ACArcDeltaMapNodeTransformationBuilt,
    ACArcDeltaMapNodeTransformationDestroyed,
    ACArcDeltaMapNodeTransformationDestroyAffected,
    ACArcDeltaMapNodeTransformationNone, //for status updates
    ACArcDeltaMapNodeTransformationGen
};

@property (nonatomic, strong) ACMap *map;
@property (nonatomic, strong) ACMapNode *node;
@property (nonatomic, assign) ACArcDeltaMapNodeTransformation transformation;

@property (nonatomic, strong) ACState *state;
@property (nonatomic, strong) NSString *status;

@end
