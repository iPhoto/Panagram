//
//  MyCollectionViewController.m
//  Panagram
//
//  Created by Johnny Lui on 10/10/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ZoomView.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

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
    _images = [@[@"http://cdn3.pcadvisor.co.uk/cmsdata/features/3401121/iPhone-5-panorama-London-Bridge.png",
                  @"http://upload.wikimedia.org/wikipedia/commons/5/5f/Chicago_Downtown_Panorama.jpg",
               @"http://photorepairshop.com/Images/Panoramic_Photo3.jpg", @"http://www.ronsaari.com/stockImages/nyc/BrooklynBridgePost911Panoramic1.jpg"] mutableCopy];
    _downloadedImages = [[NSMutableArray alloc] init];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomTap:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [tap setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    int row = [indexPath row];
    if ([_downloadedImages count] <= row || !_downloadedImages[row]) {
        myCell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(concurrentQueue, ^{
            NSURL * imageURL = [NSURL URLWithString:_images[row]];
            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage * image = [UIImage imageWithData:imageData];
            myCell.imageView.image = image;
            [_downloadedImages addObject:image];
        });
    } else {
        myCell.imageView.image = _downloadedImages[row];
    }
    [myCell.imageView setUserInteractionEnabled:YES];
    [myCell.imageView addGestureRecognizer:tap];
    [myCell.imageView setTag:indexPath.row];

    return myCell;
}

- (void)zoomTap:(UIGestureRecognizer *) sender
{
    ZoomView *zoom = [[ZoomView alloc] initWithNibName:@"ZoomView" bundle:nil];
    int tag = ((UIImageView *) sender.view).tag;
    UIImage *fs = [_downloadedImages objectAtIndex:tag];
    zoom.image = fs;
    zoom.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentViewController:zoom animated:YES completion:NULL];
}

#pragma mark -
#pragma mark UICollectionViewFlowLayoutDelegate

/*-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UIImage *image;
    int row = [indexPath row];
    
    
    NSURL * imageURL = [NSURL URLWithString:_images[row]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    //image = [UIImage imageNamed:_images[row]];
    
    return image.size;
}*/

@end
