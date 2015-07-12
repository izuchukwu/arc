//
//  ACConsole.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACConsoleData.h"
#import "ACConsoleInterface.h"

#define SHOULD_CLEAR_CONSOLE 0

@interface ACConsole : NSObject

+ (void)start;

+ (NSString *)inputForConsoleData:(ACConsoleData *)consoleData openEnded:(BOOL)openEnded;

@end
