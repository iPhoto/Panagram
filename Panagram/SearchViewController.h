//
//  SearchViewController.h
//  Panagram
//
//  Created by Johnny on 1/6/13.
//  Copyright (c) 2013 Hi Dev Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
<UISearchBarDelegate, UITableViewDataSource> {
	NSMutableArray *tableData;
	
	UIView *disableViewOverlay;
	
	UITableView *theTableView;
	UISearchBar *theSearchBar;
}

@property(retain) NSMutableArray *tableData;
@property(retain) UIView *disableViewOverlay;

@property (nonatomic, retain) IBOutlet UITableView *theTableView;
@property (nonatomic, retain) IBOutlet UISearchBar *theSearchBar;

- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;

@end