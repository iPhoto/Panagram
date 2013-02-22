//
//  AppDelegate.h
//  Panogram
//
//  Created by Johnny Lui on 10/3/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "FirstViewController.h"
@class LoginViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
extern NSString *const FBSessionStateChangedNotification;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (strong, nonatomic) LoginViewController *LoginVC;
//methods
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
+ (NSString *)FBErrorCodeDescription:(FBErrorCode) code;
@end
