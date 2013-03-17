//
//  LoginViewController.m
//  Panagram
//
//  Created by focus on 13-2-15.
//  Copyright (c) 2013年 Hi Dev Mobile. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface LoginViewController ()
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@end

@implementation LoginViewController
@synthesize HUD;
@synthesize logoView;
@synthesize inputView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.loginButton.layer.cornerRadius = 10.0;
    
    NSArray *fields = @[self.username,self.password];
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //appearing animation
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:1.5 animations:^
     {
         [logoView setFrame:CGRectMake(-130, self.logoView.frame.origin.y, 100, 100)];
         self.logoView.hidden = NO;
     }completion:^(BOOL finished)
     {
         
         [UIView animateWithDuration:1.0 animations:^{
             [logoView setFrame:CGRectMake(-100, self.logoView.frame.origin.y, 100, 100)];
             [inputView setFrame:CGRectMake(224-30, self.inputView.frame.origin.y, 120, 150)];
         } completion:^(BOOL finished){
             [UIView animateWithDuration:0.5 animations:^{
                 [inputView setFrame:CGRectMake(224, self.inputView.frame.origin.y, 120, 150)];
                 logoView.hidden = YES;
             }];
         }];
          
     }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Login:(id)sender {
    //[self showPopupMsg:@""];
    LoginConnection * connection = [[LoginConnection alloc] init];
    
    NSString * username = self.username.text;
    NSString *password = self.password.text;
    
    
    //always check if user enter username and password.
    if(username.length == 0 || password.length == 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Input"
                                                        message:@"Enter username or password"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        alert = nil; //release arlet when done
    }
    
    else
    {
        [connection setDelegate:self];
        [connection createConnection:username :password];
        
    }
    connection= nil;
    username = nil;
    password = nil;    //[self signInButtonClicked];
    /*UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UIViewController *mainController=[mainStoryBoard instantiateInitialViewController];
    mainController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:mainController animated:YES completion:^(){
        [HUD hide:YES];
    }];*/
}


/*- (void) signInButtonClicked {
    
    // create connection and process
    LoginConnection * connection = [[LoginConnection alloc] init];
    
    NSString * username = self.username.text;
    NSString *password = self.password.text;
    
    
    //always check if user enter username and password.
    if(username.length == 0 || password.length == 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Input"
                                                        message:@"Enter username or password"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        alert = nil; //release arlet when done
    }
    
    else
    {
        [connection setDelegate:self];
        [connection createConnection:username :password];
        
    }
    connection= nil;
    username = nil;
    password = nil;
    
    
}*/
// delegation method, refer to the method in Connection class
// @param login : Yes = success, No = fail
- (void) isLogInSuccessful : (BOOL)login;
{
    if(login == YES) {
        UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        UIViewController *mainController=[mainStoryBoard instantiateInitialViewController];
        mainController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [self presentViewController:mainController animated:YES completion:^(){
            [HUD hide:YES];
        }];
    } else if (login == NO)
    {
        //[self performSegueWithIdentifier:@"LoginFail" sender:self];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                        message:@"Could not find your username or password on the server"
                                                       delegate:nil
                                              cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
        [alert show];
        alert = nil; //release arlet when done
    }
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

@end
