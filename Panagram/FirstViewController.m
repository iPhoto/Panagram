//
//  FirstViewController.m
//  Panogram
//
//  Created by Johnny Lui on 10/3/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "FirstViewController.h"
#import "SimpleTableCell.h"
#import "FeedEntry.h"
#import "FeedParser.h"
#import "ImageViewController.h"
#import "Constant.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize myTable;
@synthesize feedTable;
@synthesize imageDownloadsInProgress;
@synthesize refresh;
@synthesize indexedEntries;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    // Load feed entries into array
    feedTable = [[NSMutableArray alloc] init];
    indexedEntries = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* link = [NSString stringWithFormat:@"%@/include_php/ImageEntry.php?start=0", SERVER_URL];
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:link]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void) viewDidAppear:(BOOL)animated
{
    [myTable reloadData];
}

- (void)fetchedData:(NSData *)responseData {
    if (!responseData) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed"
                                                        message:@"Could not connect to server! Check Your Network Connection" delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        alert = nil;
        return;
    }
    NSError* error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    FeedEntry *fs;
    if (!json) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        for (NSDictionary *entry in json) {
            if (![indexedEntries containsObject:[entry objectForKey:@"id"]]) {
                fs = [[FeedEntry alloc] init];
                [fs setUsername:[entry objectForKey:@"username"]];
                [fs setAvatarURL:[entry objectForKey:@"avatarURL"]];
                [fs setImageURL:[NSString stringWithFormat:@"%@/%@", SERVER_URL, [entry objectForKey:@"imageURL"]]];
                [fs setRating:[[entry objectForKey:@"rating"] floatValue]];
                [fs setDescription:[entry objectForKey:@"imgDesc"]];
                [fs setTimestamp:[entry objectForKey:@"timestamp"]];
                [fs setLikes:[[entry objectForKey:@"likes"] intValue]];
                [fs setComments:[[entry objectForKey:@"comments"] intValue]];
                [indexedEntries addObject:[entry objectForKey:@"id"]];
                [feedTable insertObject:fs atIndex:0];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *) loadImage:(NSString *)input {
    NSURL * imageURL = [NSURL URLWithString:input];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    return image;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL hasMatches = [feedTable count] > 0;
    return hasMatches ? [feedTable count] : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";
    
    int nodeCount = [self->feedTable count];
	if (nodeCount == 0 && indexPath.row == 0)
	{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        if (cell == nil)
		{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: PlaceholderCellIdentifier];
            cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
		cell.detailTextLabel.text = @"Loading…";
		
		return cell;
    }
    
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        //cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle
		//							   reuseIdentifier:simpleTableIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (nodeCount > 0)
	{
        // Set up the cell...
        FeedEntry *fs = [feedTable objectAtIndex:indexPath.row];
        if (!fs.avatarImg) {
            cell.nameAvatar.image = [self loadImage:fs.avatarURL];
            fs.avatarImg = cell.nameAvatar.image;
        }
        cell.nameLabel.text = fs.username;
        cell.imageDesc.text = fs.description;
        cell.timestamp.text = fs.timestamp;
        UIImage *starPic = [UIImage imageNamed:@"star.gif"];

        if (fs.rating >= 1)
            cell.star1.image = starPic;
        if (fs.rating >= 2)
            cell.star2.image = starPic;
        if (fs.rating >= 3)
            cell.star3.image = starPic;
        if (fs.rating >= 4)
            cell.star4.image = starPic;
        if (fs.rating >= 5)
            cell.star5.image = starPic;
		
        cell.likes.text = [NSString stringWithFormat:@"%i Like(s)", fs.likes];
        cell.comments.text = [NSString stringWithFormat:@"%i Comment(s)", fs.comments];
        
        // Only load cached images; defer new downloads until scrolling ends
        if (!fs.origImage)
        {
            if (self.myTable.dragging == NO && self.myTable.decelerating == NO)
            {
                [self startImageDownload:fs forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            //[cell.thumbnailImageView setUserInteractionEnabled:YES];
            cell.thumbnailImageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }
        else
        {
            cell.thumbnailImageView.image = fs.origImage;
            cell.nameAvatar.image = fs.avatarImg;
        }
    }
    return cell;
}

-(IBAction) refreshTable:(id) sender {

    /*NSArray *visiblePaths = [self.myTable indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visiblePaths)
    {
        //FeedStructure *appRecord = [self.feedTable objectAtIndex:indexPath.row];
        
        //if (appRecord.image) // avoid the app icon download if the app already has an icon
        //{
             SimpleTableCell *cell = (SimpleTableCell *)[self.myTable cellForRowAtIndexPath:indexPath];
            UIImage *image = cell.thumbnailImageView.image;
            
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];
            
            [stillImageSource addTarget:stillImageFilter];
            [stillImageSource processImage];
            
            UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentlyProcessedOutput];
            
            
            cell.thumbnailImageView.image = currentFilteredVideoFrame;
        //}
    }*/
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* link = [NSString stringWithFormat:@"%@/include_php/ImageEntry.php?start=%i", SERVER_URL, feedTable.count];
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:link]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    // TO FIX: Existing cells will be overwritten (not added) until refreshed again
	[myTable reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
}

#pragma mark -
#pragma mark Table cell image support

- (void)startImageDownload:(FeedEntry *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    ImageDownloader *imageDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (imageDownloader == nil)
    {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.appRecord = appRecord;
        imageDownloader.indexPathInTableView = indexPath;
        imageDownloader.delegate = self;
        [imageDownloadsInProgress setObject:imageDownloader forKey:indexPath];
        [imageDownloader startDownload];
        //[iconDownloader release];
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.feedTable count] > 0)
    {
        NSArray *visiblePaths = [self.myTable indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            FeedEntry *appRecord = [self.feedTable objectAtIndex:indexPath.row];
            
            if (!appRecord.origImage) // avoid the app icon download if the app already has an icon
            {
                [self startImageDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    ImageDownloader *imageDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (imageDownloader != nil)
    {
        SimpleTableCell *cell = (SimpleTableCell *)[self.myTable cellForRowAtIndexPath:imageDownloader.indexPathInTableView];
        cell.thumbnailImageView.image = imageDownloader.appRecord.origImage;
    }
    // Remove the ImageDownloader from the in progress list.
    // This will result in it being deallocated.
    [imageDownloadsInProgress removeObjectForKey:indexPath];
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [myTable reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Declare the view controller
    ImageViewController *anotherVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    
    // Get cell textLabel string to use in new view controller title
    //NSString *cellTitleText = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    // Get object at the tapped cell index from table data source array to display in title
    FeedEntry *tappedObj = [feedTable objectAtIndex:indexPath.row];
    
    // Set title indicating what row/section was tapped
    [anotherVC setTitle:[NSString stringWithFormat:@"%@", tappedObj.imageURL]];
    [anotherVC setEntry:tappedObj];
    //NSLog(@"You tapped section: %d - row: %d - Cell Text: %@ - Sites: %@", indexPath.section, indexPath.row, cellTitleText, tappedObj);
    
    // present it modally (not necessary, but sometimes looks better then pushing it onto the stack - depending on your App)
    [anotherVC setModalPresentationStyle:UIModalPresentationFormSheet];
    
    // Have the transition do a horizontal flip - my personal fav
    [anotherVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    // The method `presentModalViewController:animated:` is depreciated in iOS 6 so use `presentViewController:animated:completion:` instead.
    //[self.navigationController presentViewController:anotherVC animated:YES completion:NULL];
    [self.navigationController pushViewController:anotherVC animated:YES];
    
    // We are done with the view controller.  It is retained by self.navigationController so we can release it (if not using ARC)
    anotherVC = nil;
}

@end
