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

@interface FirstViewController ()

@end

@implementation FirstViewController
{
    NSArray *tableData;
    NSArray *userData;
    NSMutableArray *feedTable;
}

@synthesize myTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Load feed entries into array
    feedTable = [[NSMutableArray alloc] init];
    FeedStructure *fs = [[FeedStructure alloc] init];
    [fs setUsername: @"Johnny"];
    [fs setAvatarURL:@"http://www.sweekim.com/images/Tut_Eddy_img02.jpg"];
    [fs setImageURL:@"http://cdn3.pcadvisor.co.uk/cmsdata/features/3401121/iPhone-5-Rooftop-panorama.png"];
    [fs setRating:3];
    [fs setDescription:@"Image 1 Desc"];
    [fs setTimestamp:@"1304245000"];
    [feedTable addObject:fs];
    fs = [[FeedStructure alloc] init];
    [fs setUsername: @"James"];
    [fs setAvatarURL:@"http://www.moreart.org/wp-content/uploads/2010/02/generic_person2.jpg"];
    [fs setImageURL:@"http://cdn3.pcadvisor.co.uk/cmsdata/features/3401121/iPhone-5-panorama-London-Bridge.png"];
    [fs setRating:1];
    [fs setDescription:@"Image 2 Desc"];
    NSDate *currentTime = [NSDate date];
    double kkkk = [currentTime timeIntervalSince1970];
    [fs setTimestamp:[NSString stringWithFormat:@"%f", kkkk]];
    [feedTable addObject:fs];
    
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
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    FeedStructure *fs = [feedTable objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [self loadImage:fs.imageURL];
    cell.nameAvatar.image = [self loadImage:fs.avatarURL];
    cell.nameLabel.text = fs.username;
    cell.imageDesc.text = fs.description;
    cell.timestamp.text = [fs getStringTimestamp];
    UIImage *starPic = [self loadImage:@"http://publishersearch.files.wordpress.com/2012/08/star-smiley-face-download.gif"];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
}

@end
