//
//  ACMap.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACArc.h"
#import "ACState.h"
#import "ACMapNode.h"

#define m(x, y) CGPointMake(x, y)

#define ww 48
#define hh 12

@protocol ACMapDelegate <NSObject>

- (void)mapDidCompleteGen;

@end

@interface ACMap : NSObject

@property (nonatomic, assign, readonly) int width;
@property (nonatomic, assign, readonly) int height;

@property (nonatomic, weak) id<ACMapDelegate> delegate;

- (instancetype)initWithName:(NSString *)name;
- (void)genesis;
- (void)postGenesisForPlayerState:(ACState *)state;

- (ACMapNode *)nodeAtPoint:(CGPoint)point;
- (CGPoint)pointForNode:(ACMapNode *)node;

@end
