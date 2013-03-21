//
//  ImageViewController.m
//  Panagram
//
//  Created by Johnny on 3/19/13.
//  Copyright (c) 2013 Hi Dev Mobile. All rights reserved.
//

#import "ImageViewController.h"
#import "ZoomView.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

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
    _thumbnailImageView.image = _entry.origImage;
    _likes.text = [NSString stringWithFormat:@"%i Like(s)", _entry.likes];
    _comments.text = [NSString stringWithFormat:@"%i Comment(s)", _entry.comments];
	tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomTap:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [tap setDelegate:self];
	[_thumbnailImageView setUserInteractionEnabled:YES];
	[_thumbnailImageView addGestureRecognizer:tap];
}

- (void)zoomTap:(UIGestureRecognizer *) sender
{
    ZoomView *zoom = [[ZoomView alloc] initWithNibName:@"ZoomView" bundle:nil];
    zoom.image = _thumbnailImageView.image;
    zoom.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentViewController:zoom animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
