//
//  Detail.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *modified;

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key;

@end
