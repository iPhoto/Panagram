@class FeedEntry;
@class FirstViewController;

@protocol ImageDownloaderDelegate;

@interface ImageDownloader : NSObject
{
    FeedEntry *appRecord;
    NSIndexPath *indexPathInTableView;
    __weak id <ImageDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
}

@property (nonatomic, retain) FeedEntry *appRecord;
@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (weak) id <ImageDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol ImageDownloaderDelegate

- (void)appImageDidLoad:(NSIndexPath *)indexPath;

@end