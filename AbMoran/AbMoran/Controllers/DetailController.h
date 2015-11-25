//
//  DetailController.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailRequest.h"

@interface DetailController : UIViewController<UITableViewDataSource, UITableViewDelegate,DetailRequestDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (nonatomic, copy) NSString *pic_id;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSArray *commentArrary;

@end
