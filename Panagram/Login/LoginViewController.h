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
@interface LoginViewController : UITableViewController<UITextFieldDelegate>
//Variable
@property (strong,nonatomic) MBProgressHUD *HUD;
//UIOutlet
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIView *logoView;
@property (strong, nonatomic) IBOutlet UIView *inputView;
//IBAction
- (IBAction)Login:(id)sender;
@end
