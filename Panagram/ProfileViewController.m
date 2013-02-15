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

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)alert {
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

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
