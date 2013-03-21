//
//  ImageViewController.h
//  Panagram
//
//  Created by Johnny on 3/19/13.
//  Copyright (c) 2013 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedEntry.h"

@interface ImageViewController : UIViewController <UIGestureRecognizerDelegate> {
	UITapGestureRecognizer *tap;
}
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, retain) FeedEntry *entry;
@property (nonatomic, weak) IBOutlet UILabel *likes;
@property (nonatomic, weak) IBOutlet UILabel *comments;
@end
