//
//  ChangeAvatarRequest.m
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "ChangeAvatarRequest.h"
#import "Global.h"
#import "BLMultipartForm.h"

@implementation ChangeAvatarRequest

-(void) sendRequest:(UIImage *)image delegate:(id<ChangeAvatarRequestDelegate>)delegate{
    [self.urlConnection cancel];
    self.delegate =delegate;
    
    NSURL *url = [NSURL URLWithString:@"http://moran.chinacloudapp.cn/moran/web/user/avatar"];
    NSData *data = UIImageJPEGRepresentation(image, 0.1);
    BLMultipartForm *form =[[BLMultipartForm alloc]init];
    [form addValue:[Global shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[Global shareGlobal].user.token forField:@"token"];
    [form addValue:data forField:@"data"];
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod=@"POST";
    request.HTTPBody =[form httpBodyForImage];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *result = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
    if ([_delegate respondsToSelector:@selector(success:)]) {
        [_delegate success:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    if ([_delegate respondsToSelector:@selector(failed:error:)]) {
        [_delegate failed:self error:error];
    }
}

@end
