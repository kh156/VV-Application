//
//  IntermediateViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "IntermediateViewController.h"
#import "HomescreenViewController.h"
#import "MapAnnotation.h"

@interface IntermediateViewController ()

@end

@implementation IntermediateViewController
@synthesize myApp = _myApp;
@synthesize landmarkImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (AppDelegate *)myApp {
    if (!_myApp) {
        _myApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return _myApp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLandmarkImage];

    [self playVideo:@"DummyVideo.m4v"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadLandmarkImage {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", landmarkName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    NSString *description = ((Landmark *) [fetchResults objectAtIndex:0]).landmark_general_picture;
    NSLog(@"%@", description);
    /*CGSize size;
    size.height = 600;
    size.width = 1000;
    
    UIImage *image = [self imageWithImage:[myLibrary getImageFromFile:description] scaledToSize:size];*/
    
     
    UIImage *image = [self.myApp.lib getImageFromFile:description];
    [self.landmarkImage setImage:image];
    NSLog(@"landmarkImage set");
}

/*- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}*/




#pragma mark -
#pragma mark play video
-(void) playVideo:(NSString *)filename
{
    NSString *path = [self.myApp.lib getResourceFilepath:filename];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSLog(@"url = %@", url);
    
//    NSLog(@"system version = %f", [[[UIDevice currentDevice] systemVersion] doubleValue]);
	if (url)
    {
        MPMoviePlayerViewController* theMovie=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
        if (theMovie)
        {
            [self presentMoviePlayerViewControllerAnimated:theMovie];
            theMovie.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playbackDidFinish:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:theMovie];
            [theMovie.moviePlayer play];
        }
	}
}

- (void) playbackDidFinish:(NSNotification*)aNotification
{
	NSLog(@"Playing finished!!");
    MPMoviePlayerViewController* theMovie=[aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [self dismissMoviePlayerViewControllerAnimated];
    [theMovie.moviePlayer stop];
    theMovie.moviePlayer.initialPlaybackTime=-1.0;
    theMovie = nil;
}
@end
