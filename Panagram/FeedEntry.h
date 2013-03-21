//
//  HomeMainSecton.h
//  Panagram
//
//  Created by Johnny Lui on 10/9/12.
//  Copyright (c) 2012 Hi Dev Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedEntry : NSObject {
    NSString *username;
    NSString *avatarURL;
    UIImage *avatarImg;
    NSString *description;
    NSString *imageURL;
    int rating;
    NSString *timestamp;
    int likes;
    int comments;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *avatarURL;
@property (nonatomic, retain) UIImage *avatarImg;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) UIImage *origImage;
@property (nonatomic, assign) int rating;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, assign) int likes;
@property (nonatomic, assign) int comments;

@end