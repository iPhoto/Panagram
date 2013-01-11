//
//  SimpleTableCell.m
//  Panagram
//
//  Created by Johnny Lui on 10/24/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

@synthesize nameLabel = _nameLabel;
@synthesize imageDesc = _imageDesc;
@synthesize nameAvatar = _nameAvatar;
@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize timestamp = _timestamp;
@synthesize star1 = _star1;
@synthesize star2 = _star2;
@synthesize star3 = _star3;
@synthesize star4 = _star4;
@synthesize star5 = _star5;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
