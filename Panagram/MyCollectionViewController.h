//
//  MyCollectionViewController.h
//  Panagram
//
//  Created by Johnny Lui on 10/10/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"

@interface MyCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *tap;
}

@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *downloadedImages;

@end
