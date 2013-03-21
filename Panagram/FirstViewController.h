//
//  FirstViewController.h
//  Panogram
//
//  Created by Johnny Lui on 10/3/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "GPUImage.h"

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ImageDownloaderDelegate> {
    NSMutableArray *feedTable;
    NSMutableDictionary *imageDownloadsInProgress;
    UIBarButtonItem * refresh;
}

@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, retain) NSMutableArray *feedTable;
@property (nonatomic, retain) NSMutableArray *indexedEntries;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * refresh;
@end
