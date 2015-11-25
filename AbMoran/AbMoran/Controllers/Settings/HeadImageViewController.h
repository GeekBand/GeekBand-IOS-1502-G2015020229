//
//  HeadImageViewController.h
//  AbMoran
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeAvatarRequest.h"

@interface HeadImageViewController : UIViewController<ChangeAvatarRequestDelegate, UIImagePickerControllerDelegate>
- (IBAction)doneButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) UIImagePickerController *pickerController;
- (IBAction)editHeadImageClicked:(id)sender;

@end