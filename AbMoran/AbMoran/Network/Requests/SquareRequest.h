//
//  SquareRequest.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Square.h"

@class SquareRequest;

@protocol SquareRequestDelegate <NSObject>

- (void)squareRequestSuccess:(SquareRequest *)request dictionary:(NSDictionary *)dictionary;
- (void)squareRequestSuccess:(SquareRequest *)request squareModel:(Square *)squareModel;
- (void)squareRequestFailed:(SquareRequest *)request error:(NSError *)error;

@end

@interface SquareRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<SquareRequestDelegate> delegate;

- (void)sendSquareRequestWithParamter:(NSDictionary *)paramDic delegate:(id<SquareRequestDelegate>)delegate;

@end