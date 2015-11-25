//
//  SquareRequestParser.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquareRequestParser : NSObject

@property (nonatomic, strong)NSMutableArray *addrArray;
@property (nonatomic, strong)NSMutableArray *pictureArrary;

- (NSDictionary *)parseJson:(NSData *)data;

@end
