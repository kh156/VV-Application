//
//  IntermediateViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "IntermediateViewController.h"
#import "MapAnnotation.h"

@interface IntermediateViewController ()

@end

@implementation IntermediateViewController
@synthesize myApp = _myApp;

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

    [self playVideo:@"DummyVideo.m4v"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -
#pragma mark play video
-(void) playVideo:(NSString *)filename
{
    NSString *path = [self.myApp.lib getResourceFilepath:filename];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSLog(@"url = %@", url);
    
    NSLog(@"system version = %f", [[[UIDevice currentDevice] systemVersion] doubleValue]);
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
