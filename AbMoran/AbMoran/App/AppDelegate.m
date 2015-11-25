//
//  AppDelegate.m
//  ABMoran
//
//  Created by Arbin on 11/23/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

#import "AppDelegate.h"
#import "SquareViewController.h"
#import "MyViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)loadMainViewWithController:(UIViewController *)controller {
    // square
    UIStoryboard *squareStoryboard = [UIStoryboard storyboardWithName:@"Square" bundle:[NSBundle mainBundle]];
    SquareViewController *squareVC = [squareStoryboard instantiateViewControllerWithIdentifier:@"SquareStoryboard"];
    //    squareVC.view.backgroundColor = [UIColor redColor];
    UINavigationController *squareNav = [[UINavigationController alloc]initWithRootViewController:squareVC];
    squareNav.navigationBar.barTintColor = [[UIColor alloc]initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    squareNav.tabBarItem.title = @"广场";
    squareNav.tabBarItem.image = [UIImage imageNamed:@"square"];
    
    // my
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
    MyViewController *myVC = [myStoryboard instantiateViewControllerWithIdentifier:@"MyStoryboard"];
    myVC.tabBarItem.title = @"我的";
    myVC.tabBarItem.image = [UIImage imageNamed:@"my"];
    
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.viewControllers = @[squareNav, myVC];
    
    [controller presentViewController:self.tabBarController animated:YES completion:nil];
    
    // publish
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2-60, -25, 120, 50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
}

- (void)photoButtonClicked {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.tabBarController.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.pickerController = [[UIImagePickerController alloc]init];
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing = NO;
            self.pickerController.delegate = self;
            [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误"
                                                           message:@"无法获取照相机"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            return;
        }
    } else if (buttonIndex == 1) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate = self;
        [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
    }
}


- (void)loadLoginView {
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:[NSBundle mainBundle]];
    LoginViewController *loginController = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    [loginController dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
