//
//  FeedParser.m
//  Panagram
//
//  Created by Johnny on 1/5/13.
//  Copyright (c) 2013 Hi Dev Mobile. All rights reserved.
//

#import "FeedParser.h"

@implementation FeedParser

@synthesize feedList;

- (id) init {
    
    
    
    self = [super init];
    
    if (self) {
        
        NSString *errorDesc = nil;
        
        NSPropertyListFormat format;
        
        NSString *plistPath;
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        
        plistPath = [rootPath stringByAppendingPathComponent:@"FeedList.plist"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            
            plistPath = [[NSBundle mainBundle] pathForResource:@"FeedList" ofType:@"plist"];
            
        }
        
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              
                                              propertyListFromData:plistXML
                                              
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              
                                              format:&format
                                              
                                              errorDescription:&errorDesc];
        
        if (!temp) {
            
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
            
        }

        self.feedList = [NSMutableArray arrayWithArray:[temp objectForKey:@"Feeds"]];
        
    }
    
    return self;
    
}

@end
