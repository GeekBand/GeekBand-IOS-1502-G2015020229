//
//  DetailRequestParser.m
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "DetailRequestParser.h"
#import "Detail.h"

@implementation DetailRequestParser

- (NSArray *)parseJson:(NSData *)data {
    NSError *error = nil;
    NSMutableArray *array = nil;
    
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"ViewDetailRequestParser");
    } else {
        if ([[jsonDic class]isSubclassOfClass:[NSDictionary class]]) {
            array = [[NSMutableArray alloc]init];
            id data = [jsonDic valueForKey:@"data"];
            for (id dic in data) {
                Detail *detail = [[Detail alloc]init];
                [detail setValuesForKeysWithDictionary:dic];
                [array addObject:detail];
            }
        }
    }
    
    return array;
}

@end