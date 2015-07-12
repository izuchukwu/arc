//
//  ACArc.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACInterface.h"
#import "ACMap.h"

@class ACInterface;
@protocol ACMapDelegate;
@protocol ACInterfaceDelegate;

@interface ACArc : NSObject<ACMapDelegate>

@property (nonatomic, strong) ACInterface *interface;

- (instancetype)initWithName:(NSString *)name interfaceDelegate:(id<ACInterfaceDelegate>)interfaceDelegate;

@end
