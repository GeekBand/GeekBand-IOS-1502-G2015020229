//
//  LoginRequest.h
//  AbMoran
//
//  Created by Arbin on 11/24/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

@class LoginRequest;

#import "User.h"
#import <Foundation/Foundation.h>

@protocol LoginRequestDelegate <NSObject>

- (void)loginRequestSuccess:(LoginRequest *)request user:(User *)user;
- (void)loginRequestFailed:(LoginRequest *)request error:(NSError *)error;

@end

@interface LoginRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<LoginRequestDelegate> delegate;

- (void)sendLoginRequestWithEmail:(NSString *)email
                         password:(NSString *)password
                             gbid:(NSString *)gbid
                         delegate:(id<LoginRequestDelegate>)delegate;

@end