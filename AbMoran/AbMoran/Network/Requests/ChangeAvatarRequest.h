//
//  ChangeAvatarRequest.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ChangeAvatarRequest;

@protocol ChangeAvatarRequestDelegate<NSObject>
-(void) success:(ChangeAvatarRequest *) request;
-(void) failed:(ChangeAvatarRequest *) request error :(NSError *)error;
@end

@interface ChangeAvatarRequest : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,strong) NSURLConnection *urlConnection;
@property(nonatomic,strong) NSMutableData *receivedData;
@property(nonatomic,strong)id<ChangeAvatarRequestDelegate> delegate;

-(void)sendRequest:(UIImage *)image delegate:(id<ChangeAvatarRequestDelegate>)delegate;

@end
