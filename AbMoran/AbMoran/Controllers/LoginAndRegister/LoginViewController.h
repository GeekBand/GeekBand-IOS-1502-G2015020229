//
//  LoginViewController.h
//  AbMoran
//
//  Created by Arbin on 11/23/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginRequest.h"
#import "User.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate, LoginRequestDelegate>

@property (nonatomic, strong) LoginRequest *loginRequest;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;

@end
