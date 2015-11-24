//
//  LoginRequestParser.m
//  AbMoran
//
//  Created by Arbin on 11/24/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "LoginRequestParser.h"

@implementation LoginRequestParser

- (User *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    if (error) {
        NSLog(@"Error in JYLoginRequestParser.parseJson");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            User *user = [[User alloc]init];
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                user.loginReturnMessage = returnMessage;
            }
            id data = [jsonDic valueForKey:@"data"];
            if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                id userId = [data valueForKey:@"user_id"];
                if ([[userId class] isSubclassOfClass:[NSString class]]) {
                    user.userId = userId;
                }
                
                id token = [data valueForKey:@"token"];
                if ([[token class] isSubclassOfClass:[NSString class]]) {
                    user.token = token;
                }
                
                id userName = [data valueForKey:@"user_name"];
                if ([[userName class] isSubclassOfClass:[NSString class]]) {
                    user.username = userName;
                }
            }
            return user;
        }
    }
    
    return nil;
}

@end
