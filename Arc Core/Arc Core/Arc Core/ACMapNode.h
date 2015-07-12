//
//  ACMapNode.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ACMapNodeComponent.h"
#import "ACState.h"

@interface ACMapNode : NSObject

@property (nonatomic, weak) ACState *state;

- (instancetype)initWithComponents:(NSArray *)components;
- (void)addComponent:(id<ACMapNodeComponent>)component;
     
- (NSString *)nodeTitle;
- (NSString *)nodeChar;

- (NSString *)status;

@end
