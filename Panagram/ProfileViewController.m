//
//  ProfileViewController.m
//  Panagram
//
//  Created by Johnny on 2/14/13.
//  Copyright (c) 2013 Hi Dev Mobile. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "IASKAppSettingsViewController.h"
@interface ProfileViewController ()
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (nonatomic, strong) FBUserSettingsViewController *fbSettingsViewController;
@end

@implementation ProfileViewController
@synthesize HUD;
@synthesize fbSettingsViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*-(IBAction)alert {
    IASKAppSettingsViewController *appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
    appSettingsViewController.delegate = self;
    appSettingsViewController.showDoneButton = YES;
    UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:appSettingsViewController];
    //[self presentModalViewController:aNavController animated:YES];
    [self presentViewController:aNavController animated:YES completion:nil];

}
- (void)settingsViewControllerDidEnd:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user = [defaults stringForKey:@"name_preference"];
    NSString *pw = [defaults stringForKey:@"password_preference"];

}*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.firstNameBG.layer.cornerRadius = 10.0;
    self.lastNameBG.layer.cornerRadius = 10.0;
    self.genderBG.layer.cornerRadius = 10.0;
    self.birthDateBG.layer.cornerRadius = 10.0;
    NSArray *fields = @[ self.userImage, self.firstName,
                         self.lastName, self.gender,self.email,
                         self.fackbook,self.birthDate];
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)settingsButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
    
    UIStoryboard *LoginStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryBoard" bundle:nil];
    LoginViewController *LoginVC = [LoginStoryboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
    appDelegate.window.rootViewController = LoginVC;
    /*HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"";
    HUD.detailsLabelText = @"Successfully log out the facebook!";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:2];*/
}

-(IBAction)LogOutClicked:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Sign Out"
                                  otherButtonTitles:nil];
    
	actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
	[actionSheet showInView:[self.navigationController view] ];
}

-(void) showPopupMsg:(NSString *)msg {
    HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    HUD.dimBackground = YES;
    HUD.labelText = msg;
    HUD.removeFromSuperViewOnHide = YES;
}

#pragma mark - BSKeyboard
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [keyboardControls.activeField resignFirstResponder];
}
- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    UIView *view = keyboardControls.activeField.superview.superview;
    [self.tableView scrollRectToVisible:view.frame animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.keyboardControls setActiveField:textView];
}

#pragma  mark - FacebookSDK
- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.lastName.text = user.last_name;
                 self.userImage.profileID = user.id;
                 self.firstName.text = user.first_name;
             }
         }];
    }
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet cancelButtonIndex])
        return;
    if(buttonIndex == 0)
    {
        UIStoryboard *LoginStoryBoard=[UIStoryboard storyboardWithName:@"LoginStoryBoard" bundle:nil];
        UIViewController *loginController=[LoginStoryBoard instantiateInitialViewController];
        loginController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentViewController:loginController animated:YES completion:^(){
            [HUD hide:YES];
        }];
    }
}
@end
