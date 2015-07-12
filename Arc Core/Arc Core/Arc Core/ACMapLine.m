//
//  ACMapLine.m
//  Arc Core
//
//  Created by Izuchukwu Elechi on 7/12/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "ACMapLine.h"

@implementation ACMapLine

+ (NSArray *)turnVectors {
    return @[@"{0,-1}", @"{1,-1}", @"{1,0}", @"{1,1}", @"{0,1}", @"{-1,1}", @"{-1,0}", @"{-1,-1}"];
}

@end
