//
//  SecondViewController.h
//  Panogram
//
//  Created by Johnny Lui on 10/3/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomViewController : UIViewController <UIScrollViewDelegate> {
    UIImageView *image;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *exit;
-(IBAction) exit:(id) sender;

@end
