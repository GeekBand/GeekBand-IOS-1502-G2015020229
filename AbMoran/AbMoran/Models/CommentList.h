//
//  CommentList.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CommentList : UITableViewCell

@property (nonatomic, retain) UILabel *userNameOfComment;
@property (nonatomic, retain) UILabel *textOfComment;
@property (nonatomic, retain) UIImageView *headImageOfComment;
@property (nonatomic, retain) UILabel *dateOfComment;

@end
