//
//  SquareCell.m
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "SquareCell.h"
#import "SquareCollectionCell.h"
#import "Picture.h"

@implementation SquareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SquareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    Picture *picture = self.dataArr[indexPath.row];
    NSString *pic = picture.pic_link;
    pic = [pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *pic_url = [NSURL URLWithString:pic];
    [cell.pictureImageView sd_setImageWithURL:pic_url];
    cell.titleLabel.text = picture.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd", indexPath.row);
    Picture *picture = self.dataArr[indexPath.row];
    self.squareVC.pic_url = picture.pic_link;
    self.squareVC.pic_id = picture.pic_id;
    [self.squareVC toCheckPicture];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end