//
//  ACConsoleInterface.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACArc.h"

@interface ACConsoleInterface : NSObject<ACInterfaceDelegate>

+ (ACConsoleInterface *)standardInterface;

- (void)start;

@end
