//
//  DetailRequest.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailRequest;

@protocol DetailRequestDelegate <NSObject>

- (void)viewDetailRequestSuccess:(DetailRequest *)request data:(NSArray *)data;
- (void)viewDetailRequestFailed:(DetailRequest *)request error:(NSError *)error;

@end

@interface DetailRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<DetailRequestDelegate> delegate;

- (void)sendViewDetailRequest:(NSDictionary *)paramDic delegate:(id<DetailRequestDelegate>) delegate;

@end
