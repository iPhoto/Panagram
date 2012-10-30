//
//  FirstViewController.h
//  Panogram
//
//  Created by Johnny Lui on 10/3/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationController : UINavigationController {
    IBOutlet UIImageView *myImageView;
}
- (void) loadImage:(NSString *)input;
-(IBAction)imagePress:(id)sender;
@end