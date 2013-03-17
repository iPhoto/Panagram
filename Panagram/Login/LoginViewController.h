//
//  LoginViewController.h
//  Panagram
//
//  Created by focus on 13-2-15.
//  Copyright (c) 2013年 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BSKeyboardControls.h"
#import "LoginConnection.h"
@interface LoginViewController : UITableViewController<ProcessAfterLogin,BSKeyboardControlsDelegate,UITextFieldDelegate>
//Variable
@property (strong,nonatomic) MBProgressHUD *HUD;
//UIOutlet
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIView *logoView;
@property (strong, nonatomic) IBOutlet UIView *inputView;
//IBAction
- (IBAction)Login:(id)sender;
// delegation method, refer to the method in Connection class
// @param login : Yes = success, No = fail
- (void) isLogInSuccessful : (BOOL)login;

@end
