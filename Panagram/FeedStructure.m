//
//  HomeMainSecton.m
//  Panagram
//
//  Created by Johnny Lui on 10/9/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import "FeedStructure.h"

@implementation FeedStructure

@synthesize username;
@synthesize avatarURL;
@synthesize avatarImg;
@synthesize description;
@synthesize imageURL;
@synthesize origImage;
@synthesize rating;
@synthesize timestamp;

- (NSString *) getStringTimestamp {
    NSTimeInterval _interval=[timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];

    return [formatter stringFromDate:date];
}

@end
