//
//  SecondViewController.m
//  Panogram
//
//  Created by Johnny Lui on 10/3/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "ZoomViewController.h"

@interface ZoomViewController ()

@end

@implementation ZoomViewController

@synthesize scrollView = _scrollView;
@synthesize image = _image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    //_scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	//_scrollView.backgroundColor = [UIColor whiteColor];
	//_scrollView.delegate = self;
	//_filter1.image = _image;
	//_scrollView.contentSize = image.frame.size;
	//[_scrollView addSubview:image];
	
	//_scrollView.minimumZoomScale = _scrollView.frame.size.width / image.frame.size.width;
	//_scrollView.maximumZoomScale = 2.0;
	//[_scrollView setZoomScale:_scrollView.minimumZoomScale];
    
	//self.view = _scrollView;
    
}

- (void)viewDidUnload {
	image = nil;
}


- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView {
	CGSize boundsSize = scroll.bounds.size;
    CGRect frameToCenter = rView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }
    else {
        frameToCenter.origin.y = 0;
    }
	
	return frameToCenter;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    image.frame = [self centeredFrameForScrollView:scrollView andUIView:image];;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) exit:(id) sender {
    [self dismissViewControllerAnimated:YES completion: nil];
}

@end
