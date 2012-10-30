//
//  MyCollectionViewController.m
//  Panagram
//
//  Created by Johnny Lui on 10/10/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "MyCollectionViewController.h"

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
    _images = [@[@"http://imageshack.us/a/img577/2921/minecrafti.png",
                  @"http://imageshack.us/a/img23/5834/roofh.png"] mutableCopy];
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
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
    
    //UIImage *image;
    int row = [indexPath row];
    
    //image = [UIImage imageNamed:_images[row]];
    
    //myCell.imageView.image = image;
    
    
    NSURL * imageURL = [NSURL URLWithString:_images[row]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    myCell.imageView.image = image;
    
    
    
    return myCell;
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
