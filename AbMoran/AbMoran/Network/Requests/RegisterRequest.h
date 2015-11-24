//
//  RegisterRequest.h
//  AbMoran
//
//  Created by Arbin on 11/24/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "User.h"

@class RegisterRequest;

@protocol RegisterRequestDeleage <NSObject>

- (void)registerRequestSuccess:(RegisterRequest *)request user:(User *)user;
- (void)registerRequestFailed:(RegisterRequest *)request error:(NSError *)error;

@end

@interface RegisterRequest: NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id<RegisterRequestDeleage> delegate;

- (void)sendRegisterRequestWithUserName:(NSString *)userName email:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid delegate:(id<RegisterRequestDeleage>)delegate;

@end
