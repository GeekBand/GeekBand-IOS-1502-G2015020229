//
//  RegisterRequestParser.h
//  AbMoran
//
//  Created by Arbin on 11/24/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface RegisterRequestParser : NSObject
- (User *)parseJson:(NSData *)data;
@end
