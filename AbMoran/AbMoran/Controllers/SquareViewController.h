//
//  SquareViewController.h
//  AbMoran
//
//  Created by Arbin on 11/24/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SquareRequest.h"
#import "MJRefresh.h"
#import "KxMenu.h"

@interface SquareViewController : UIViewController <SquareRequestDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *pic_id;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *locationDic;

- (void)toCheckPicture;

@end
