//
//  CameraAppViewController.m
//  Panagram
//
//  Created by Johnny Lui on 10/11/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "CameraAppViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraAppViewController ()

@end

@implementation CameraAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@synthesize imageView,choosePhotoBtn, takePhotoBtn;

-(IBAction) getPhoto:(id) sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
	if((UIButton *) sender == choosePhotoBtn) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
    DLCImagePickerController *picker2 = [[DLCImagePickerController alloc] init];
    picker2.delegate = self;
    [self presentViewController:picker2 animated:YES completion:nil];
	//[self presentViewController:picker animated:YES completion:NULL];
}

-(IBAction) addFilter:(id) sender {
    //UIStoryboard *storyboard = self.storyboard;
    
    //ViewControllerFilters *svc = [storyboard instantiateViewControllerWithIdentifier:@"FilterView"];
    //svc.origImage = imageView.image;
    
    DLCImagePickerController *picker = [[DLCImagePickerController alloc] init];
    picker.delegate = self;
    //[self presentModalViewController:picker animated:YES];
    
    // Configure the new view controller here.
    
    
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void) takePhoto:(id)sender{
    DLCImagePickerController *picker = [[DLCImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}


-(void) imagePickerControllerDidCancel:(DLCImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerController:(DLCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (info) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageDataToSavedPhotosAlbum:[info objectForKey:@"data"] metadata:nil completionBlock:^(NSURL *assetURL, NSError *error)
         {
             if (error) {
                 NSLog(@"ERROR: the image failed to be written");
             }
             else {
                 NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             }
         }];
    }
}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	//[picker dismissViewControllerAnimated:YES completion:NULL];
	//imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//}

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

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
@end
