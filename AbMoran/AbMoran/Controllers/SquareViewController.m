//
//  SquareViewController.m
//  AbMoran
//
//  Created by Arbin on 11/24/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "SquareViewController.h"
#import "Global.h"
#import "SquareCell.h"
#import "DetailController.h"

@interface SquareViewController ()

@end

@implementation SquareViewController

- (void)toCheckPicture {
    UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"ViewDetail" bundle:[NSBundle mainBundle]];
    DetailController *detailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"ViewDetail"];
    [detailVC.photoImage sd_setImageWithURL:[NSURL URLWithString:self.pic_url]];
    detailVC.pic_id = self.pic_id;
    detailVC.pic_url = self.pic_url;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)requestAllData {
    NSDictionary *paramDic = @{@"user_id":[Global shareGlobal].user.userId, @"token":[Global shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1000"};
    SquareRequest *squareRequest = [[SquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParamter:paramDic delegate:self];
}

- (void)request500mData {
    NSDictionary *paramDic = @{@"user_id":[Global shareGlobal].user.userId, @"token":[Global shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"500"};
    SquareRequest *squareRequest = [[SquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParamter:paramDic delegate:self];
}

- (void)request1000mData {
    NSDictionary *paramDic = @{@"user_id":[Global shareGlobal].user.userId, @"token":[Global shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1000"};
    SquareRequest *squareRequest = [[SquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParamter:paramDic delegate:self];
}

- (void)request1500mData {
    NSDictionary *paramDic = @{@"user_id":[Global shareGlobal].user.userId, @"token":[Global shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1500"};
    SquareRequest *squareRequest = [[SquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParamter:paramDic delegate:self];
}

- (void)squareRequestSuccess:(SquareRequest *)request dictionary:(NSDictionary *)dictionary {
    self.addrArray = [NSMutableArray arrayWithArray:[dictionary allKeys]];
    self.dataDic = dictionary;
    [self.tableView reloadData];
}

- (void)squareRequestFailed:(SquareRequest *)request error:(NSError *)error {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"addrArray:%zd", self.addrArray.count);
    return self.addrArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SquareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"squareCell" forIndexPath:indexPath];
    if (!cell) { // TODO: why never go here?
        cell = [[SquareCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"squareCell"];
    }
    
    Square *square = self.addrArray[indexPath.row][0];
    cell.squareVC = self;
    cell.locationLabel.text = square.addr;
    cell.dataArr = self.dataDic[self.addrArray[indexPath.row]];
    cell.collectionView.delegate = cell;
    cell.collectionView.dataSource = cell;
    [cell.collectionView reloadData];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // location
    self.locationDic = [NSMutableDictionary dictionary];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误"
                                                       message:@"定位错误"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
        [alert show];
    }
    
    // NavigationBar settings
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.frame = CGRectMake(0, 0, 200, 35);
    //    self.titleButton.backgroundColor = [UIColor blueColor];
    [self.titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
    self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    self.navigationItem.titleView = self.titleButton;
    
    // tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        });
    }];
    self.tableView.header.automaticallyChangeAlpha = YES;
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.footer endRefreshing];
        });
    }];
    
    //    self.tableView.backgroundColor = [UIColor yellowColor];
    
    [self requestAllData];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.locationDic = [NSMutableDictionary dictionary];
    NSString *latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    [self.locationDic setValue:latitude forKey:@"latitude"];
    [self.locationDic setValue:longitude forKey:@"longitude"];
    
    CLLocationDegrees latitude2 = newLocation.coordinate.latitude;
    CLLocationDegrees longitude2 = newLocation.coordinate.longitude;
    
    CLLocation *c = [[CLLocation alloc]initWithLatitude:latitude2 longitude:longitude2];
    CLGeocoder *revGeo = [[CLGeocoder alloc]init];
    [revGeo reverseGeocodeLocation:c completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            NSLog(@"Street address %@", [dict objectForKey:@"Street"]);
            [self.locationDic setValue:dict[@"Name"] forKey:@"location"];
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)titleButtonClicked:(UIButton *)button {
    NSArray *menuItems = @[
                           [KxMenuItem menuItem:@"显示全部"
                                          image:nil
                                         target:self
                                         action:@selector(requestAllData)],
                           [KxMenuItem menuItem:@"附近500米"
                                          image:nil
                                         target:self
                                         action:@selector(request500mData)],
                           [KxMenuItem menuItem:@"附近1000米"
                                          image:nil
                                         target:self
                                         action:@selector(request1000mData)],
                           
                           [KxMenuItem menuItem:@"附近1500米"
                                          image:nil
                                         target:self
                                         action:@selector(request1500mData)],
                           ];
    
    UIButton *btn = (UIButton *)button;
    CGRect editImageFrame = btn.frame;
    UIView *targetSuperView = btn.superview;
    CGRect rect = [targetSuperView convertRect:editImageFrame toView:[[UIApplication sharedApplication] keyWindow]];
    
    [KxMenu showMenuInView:[[UIApplication sharedApplication] keyWindow] fromRect:rect menuItems:menuItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end