//
//  ACConsoleData.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACConsoleData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *map;
@property (nonatomic, copy) NSArray *status;

@property (nonatomic, assign) BOOL shouldRead;

// Note: if shouldRead is false, no actions will be printed

@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, copy) NSArray *actions;

@end
