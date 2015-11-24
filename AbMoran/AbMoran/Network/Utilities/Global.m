//
//  Global.m
//  AbMoran
//
//  Created by Arbin on 11/24/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "Global.h"


static Global *global = nil;

@implementation Global

+ (Global *)shareGlobal {
    if (global == nil) {
        global = [[Global alloc]init];
    }
    return global;
}

@end
