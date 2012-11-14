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
@synthesize rotation;

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
//    NSLog(@"image = %@", description);
    CGSize size;
    size.height = 600;
    size.width = 1000;
     
    UIImage *image = [self.myApp.lib getImageFromFile:description];
    [self.landmarkImage setImage:image];
    rotation = 1;
    //NSLog(@"landmarkImage set");
}

/*-(IBAction)rotateView:(id)sender {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Intermediate" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"Landmark == %@", landmarkName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    NSString *description = ((Intermediate* ) [fetchResults objectAtIndex:rotation]).image;
    UIImage *image = [self.myApp.lib getImageFromFile:description];
    [self.landmarkImage setImage:image];
    rotation = (rotation+1)%4;
} */


- (IBAction)playVideo:(id) sender{
    [self initAndPlayVideo:@"DummyVideo.m4v"];
}


#pragma mark -
#pragma mark play video
-(void) initAndPlayVideo:(NSString *)filename
{
    NSString *path = [self.myApp.lib getResourceFilepath:filename];
    NSURL* url = [NSURL fileURLWithPath:path];
//    NSLog(@"video url = %@", url);
        
//    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(playbackDidFinish:)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:moviePlayer];    
//    moviePlayer.controlStyle = MPMovieControlStyleDefault;
//    moviePlayer.shouldAutoplay = YES;
//    [self.view addSubview:moviePlayer.view];
////    [moviePlayer prepareToPlay];
//    [moviePlayer setFullscreen:YES animated:YES];

        MPMoviePlayerViewController* theMovie=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
        if (theMovie)
        {
            NSLog(@"movie player created!!!");
            [self presentMoviePlayerViewControllerAnimated:theMovie];
            theMovie.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playbackDidFinish:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:theMovie];
            [theMovie.moviePlayer play];
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
