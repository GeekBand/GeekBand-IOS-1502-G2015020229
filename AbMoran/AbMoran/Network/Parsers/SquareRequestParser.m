//
//  SquareRequestParser.m
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "SquareRequestParser.h"
#import "Square.h"
#import "Picture.h"

@implementation SquareRequestParser

-(NSDictionary *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (error) {
        NSLog(@"SquareRequestParser does not work.");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id data = [[jsonDic valueForKey:@"data"] allValues];
            for (id dic in data) {
                self.addrArray = [NSMutableArray array];
                self.pictureArrary = [NSMutableArray array];
                Square *square = [[Square alloc]init];
                [square setValuesForKeysWithDictionary:dic[@"node"]];
                for (id picDict in dic[@"pic"]) {
                    Picture *pic = [[Picture alloc]init];
                    [pic setValuesForKeysWithDictionary:picDict];
                    [self.pictureArrary addObject:pic];
                }
                [self.addrArray addObject:square];
                [dictionary setObject:_pictureArrary forKey:_addrArray];
            }
        }
    }
    return dictionary;
}

@end
