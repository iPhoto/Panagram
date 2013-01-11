//
//  CameraAppViewController.h
//  Panagram
//
//  Created by Johnny Lui on 10/11/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLCImagePickerController.h"

@interface CameraAppViewController : UIViewController < DLCImagePickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate > {
	UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton *takePhotoBtn;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *filters;

-(IBAction) getPhoto:(id) sender;
-(IBAction) addFilter:(id) sender;
@end
