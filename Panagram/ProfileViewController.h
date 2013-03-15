//
//  ProfileViewController.h
//  Panagram
//
//  Created by Johnny on 2/14/13.
//  Copyright (c) 2013 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "IASKAppSettingsViewController.h"
#import "MBProgressHUD.h"
#import "BSKeyboardControls.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface ProfileViewController : UITableViewController<BSKeyboardControlsDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate>
//-(IBAction)alert;

//Variable
@property (strong,nonatomic) MBProgressHUD *HUD;
//UI IBOutlet
//@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userImage;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *fackbook;
@property (strong, nonatomic) IBOutlet UITextField *birthDate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//Round Background IBOutlet
@property (strong, nonatomic) IBOutlet UIButton *lastNameBG;
@property (strong, nonatomic) IBOutlet UIButton *firstNameBG;
@property (strong, nonatomic) IBOutlet UIButton *genderBG;
@property (strong, nonatomic) IBOutlet UIButton *birthDateBG;
//IBAction
-(IBAction)LogOutClicked:(id)sender;
@end
