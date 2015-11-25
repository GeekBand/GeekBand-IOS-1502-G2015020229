//
//  DetailRequestParser.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DetailRequestParser : NSObject

- (NSArray *)parseJson:(NSData *)data;

@end
