//
//  FirstViewController.m
//  Panogram
//
//  Created by Johnny Lui on 10/3/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "FirstViewController.h"
#import "SimpleTableCell.h"
#import "FeedStructure.h"
#import "ZoomView.h"
#import "FeedParser.h"


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
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://192.168.0.102:8888/include_php/ImageEntry.php?start=0"]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomTap:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [tap setDelegate:self];
    
}
- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    //ARRAY OR DICT DEPENDING ON YOUR DATA STRUCTURE
    NSArray *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    FeedStructure *fs;
    if (!json) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        for (NSDictionary *entry in json) {
            if (![indexedEntries containsObject:[entry objectForKey:@"id"]]) {
            fs = [[FeedStructure alloc] init];
            [fs setUsername:[entry objectForKey:@"username"]];
            [fs setAvatarURL:[entry objectForKey:@"avatarURL"]];
            [fs setImageURL:[entry objectForKey:@"imageURL"]];
            [fs setRating:[[entry objectForKey:@"rating"] floatValue]];
            [fs setDescription:[entry objectForKey:@"imgDesc"]];
            [fs setTimestamp:[entry objectForKey:@"timestamp"]];
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
    return [feedTable count];
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
        FeedStructure *fs = [feedTable objectAtIndex:indexPath.row];
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
        [cell.thumbnailImageView setUserInteractionEnabled:YES];
        [cell.thumbnailImageView addGestureRecognizer:tap];
        [cell.thumbnailImageView setTag:indexPath.row];
        
    }
    
    return cell;
}

- (void)zoomTap:(UIGestureRecognizer *) sender
{
    ZoomView *zoom = [[ZoomView alloc] initWithNibName:@"ZoomView" bundle:nil];
    int tag = ((UIImageView *) sender.view).tag;
    FeedStructure *fs = [feedTable objectAtIndex:tag];
    zoom.image = fs.origImage;
    zoom.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentViewController:zoom animated:YES completion:NULL];
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
        NSString* script = [NSString stringWithFormat:@"http://192.168.0.102:8888/include_php/ImageEntry.php?start=%i",feedTable.count];
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:script]];
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

- (void)startImageDownload:(FeedStructure *)appRecord forIndexPath:(NSIndexPath *)indexPath
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
            FeedStructure *appRecord = [self.feedTable objectAtIndex:indexPath.row];
            
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

//-(NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}

@end
