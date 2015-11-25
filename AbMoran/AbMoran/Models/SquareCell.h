//
//  SquareCell.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareViewController.h"
#import "UIImageView+WebCache.h"

@interface SquareCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) SquareViewController *squareVC;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) NSArray *dataArr;

@end