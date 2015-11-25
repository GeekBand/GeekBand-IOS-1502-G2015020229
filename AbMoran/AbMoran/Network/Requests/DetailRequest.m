//
//  DetailRequest.m
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "DetailRequest.h"
#import "DetailRequestParser.h"

@implementation DetailRequest

- (void)sendViewDetailRequest:(NSDictionary *)paramDic delegate:(id<DetailRequestDelegate>)delegate {
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web/comment?user_id=%@&token=%@&pic_id=%@", paramDic[@"user_id"], paramDic[@"token"], paramDic[@"pic_id"]];
    NSString *encodedURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpReponse = (NSHTTPURLResponse *)response;
    if (httpReponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *string = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"ViewDetail receive data: %@", string);
    
    if ([_delegate respondsToSelector:@selector(viewDetailRequestSuccess:data:)]) {
        DetailRequestParser *parser = [[DetailRequestParser alloc]init];
        [_delegate viewDetailRequestSuccess:self data:[parser parseJson:self.receivedData]];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([_delegate respondsToSelector:@selector(viewDetailRequestFailed:error:)]) {
        [_delegate viewDetailRequestFailed:self error:error];
    }
}

@end
