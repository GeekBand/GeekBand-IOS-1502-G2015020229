//
//  DetailController.m
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//


#import "DetailController.h"
#import "Global.h"
#import "CommentList.h"
#import "Detail.h"

@interface DetailController () {
    UIActivityIndicatorView *activity;
    UITableView *_tableView;
}

@end

@implementation DetailController

- (void)viewDetailRequestSuccess:(DetailRequest *)request data:(NSArray *)data {
    [activity stopAnimating];
    self.commentArrary = data;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.photoImage.frame.size.height+self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewDetailRequestFailed:(DetailRequest *)request error:(NSError *)error {
    [activity stopAnimating];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.commentArrary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIndentifier";
    CommentList *cell = (CommentList *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CommentList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    Detail *detail = self.commentArrary[indexPath.row];
    cell.textOfComment.text = detail.comment;
    cell.dateOfComment.text = detail.modified;
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    CGFloat width = self.view.frame.size.width / 2;
    [activity setCenter:CGPointMake(width, 160)];
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:activity];
    [activity startAnimating];
    self.photoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pic_url]]];
    [activity startAnimating];
    
    NSString *token = [Global shareGlobal].user.token;
    NSString *userId = [Global shareGlobal].user.userId;
    NSDictionary *dic = @{@"user_id":userId, @"token":token, @"pic_id":self.pic_id};
    
    DetailRequest *request = [[DetailRequest alloc]init];
    [request sendViewDetailRequest:dic delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end