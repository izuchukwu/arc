//
//  ACInterface.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACMap.h"
#import "ACArcDelta.h"

@class ACArcDelta;

@protocol ACInterfaceDelegate <NSObject>

- (void)arcDidUpdateWithDelta:(ACArcDelta *)arcDelta;

@end

@interface ACInterface : NSObject

@property (nonatomic, weak) id<ACInterfaceDelegate> delegate;
@property (nonatomic, copy, readonly) NSString *name;

// For Arc

- (instancetype)initWithName:(NSString *)name;
- (void)arcDidUpdateWithDelta:(ACArcDelta *)arcDelta;

@end
