//
//  ACMapNodeComponent.h
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/11/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ACMapNodeComponent <NSObject>

@property (nonatomic, weak) id node;

- (NSString *)componentTitle;
- (NSString *)run; //returns status title

@end