//
//  SearchViewController.m
//  Panagram
//
//  Created by Johnny on 1/6/13.
//  Copyright (c) 2013 Hi Dev Mobile. All rights reserved.
//

//
//  SearchViewController.m
//
#import "SearchViewController.h"

@implementation SearchViewController
@synthesize tableData;
@synthesize disableViewOverlay;
@synthesize theSearchBar;
@synthesize theTableView;


// Initialize tableData and disabledViewOverlay
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData =[[NSMutableArray alloc]init];
    self.disableViewOverlay = [[UIView alloc]
                               initWithFrame:CGRectMake(0.0f,44.0f,320.0f,416.0f)];
    self.disableViewOverlay.backgroundColor=[UIColor blackColor];
    self.disableViewOverlay.alpha = 0;
}

// Since this view is only for searching give the UISearchBar
// focus right away
- (void)viewDidAppear:(BOOL)animated {
    [self.theSearchBar becomeFirstResponder];
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText {
    // We don't want to do anything until the user clicks
    // the 'Search' button.
    // If you wanted to display results as the user types
    // you would do that here.
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // searchBarTextDidBeginEditing is called whenever
    // focus is given to the UISearchBar
    // call our activate method so that we can do some
    // additional things when the UISearchBar shows.
    [self searchBar:searchBar activate:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    // searchBarTextDidEndEditing is fired whenever the
    // UISearchBar loses focus
    // We don't need to do anything here.
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    // Clear the search text
    // Deactivate the UISearchBar
    searchBar.text=@"";
    [self searchBar:searchBar activate:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // Do the search and show the results in tableview
    // Deactivate the UISearchBar
	
    // You'll probably want to do this on another thread
    // SomeService is just a dummy class representing some
    // api that you are using to do the search
    NSArray *results = [[NSMutableArray alloc] init];
	
    [self searchBar:searchBar activate:NO];
	
    [self.tableData removeAllObjects];
    [self.tableData addObjectsFromArray:results];
    [self.theTableView reloadData];
}

// We call this when we want to activate/deactivate the UISearchBar
// Depending on active (YES/NO) we disable/enable selection and
// scrolling on the UITableView
// Show/Hide the UISearchBar Cancel button
// Fade the screen In/Out with the disableViewOverlay and
// simple Animations
- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active{
    self.theTableView.allowsSelection = !active;
    self.theTableView.scrollEnabled = !active;
    if (!active) {
        [disableViewOverlay removeFromSuperview];
        [searchBar resignFirstResponder];
    } else {
        self.disableViewOverlay.alpha = 0;
        //[self.view addSubview:self.disableViewOverlay];
		
        [UIView beginAnimations:@"FadeIn" context:nil];
        [UIView setAnimationDuration:0.5];
        self.disableViewOverlay.alpha = 0.6;
        [UIView commitAnimations];
		
        // probably not needed if you have a details view since you
        // will go there on selection
        NSIndexPath *selected = [self.theTableView
                                 indexPathForSelectedRow];
        if (selected) {
            [self.theTableView deselectRowAtIndexPath:selected
                                             animated:NO];
        }
    }
    [searchBar setShowsCancelButton:active animated:YES];
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"SearchResult";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:MyIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:MyIdentifier];
    }
	
    //id *data = [self.tableData objectAtIndex:indexPath.row];
    //cell.textLabel.text = data.name;
    return cell;
}

#pragma mark -
#pragma mark Memory Management Methods

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    theTableView = nil;
    theSearchBar = nil;
}

@end

