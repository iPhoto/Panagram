//
//  ZoomView.h
//  Panagram
//
//  Created by Johnny on 12/26/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomView : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *exit;
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
-(IBAction) exit:(id) sender;
@end
