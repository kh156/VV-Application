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

/**
 * Initialize the view
 * param: view name and bundle
 * return: self
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 * Retrieve the app delegate
 * return: App delegate instance
 */
- (AppDelegate *)myApp {
    if (!_myApp) {
        _myApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return _myApp;
}

/**
 * Additional set up of view. Specifically, loads an image of the landmark being viewed.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IntermediateView viewDidLoad");
    [self loadLandmarkImage];
}

/**
 * Function to implement actions to be taken if application memory limit is reached.
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Fetches the default landmark image to be shown in the view and displays it.
 */
-(void) loadLandmarkImage {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", self.myApp.coreData.landmarkName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    Landmark *lmark = ((Landmark *) [fetchResults objectAtIndex:0]);
    for (Intermediate *interm in lmark.intermediates) {
        //NSLog(@"%@",interm.num);
        if ([interm.num isEqualToString:@"N"]) {
            UIImage *img = [self.myApp.lib getImageFromFile: interm.image];
            [self.landmarkImage setImage:img];
            rotation = @"E";
            //NSLog(@"landmarkImage set");
            break;
        }
    }
}

/**
 * Upon the click of the "rotate view" button in the view fetches a new perspective for the landmark being viewed and 
 * replaces the current perspective of the landmark image with the new one.
 * param: UIBarButtonItem i.e. "rotate view" button
 */
- (IBAction)rotateView:(UIBarButtonItem *)sender {
   // NSLog(@"rotating view!");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity: des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", self.myApp.coreData.landmarkName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    Landmark *lmark = ((Landmark *) [fetchResults objectAtIndex:0]);
    for (Intermediate *interm in lmark.intermediates) {
        if ([interm.num isEqualToString:rotation]) {
            UIImage *img = [self.myApp.lib getImageFromFile: interm.image];
            [self.landmarkImage setImage:img];
            //NSLog(@"%@",interm.num);
            [self nextRotation:rotation];
            //NSLog(@"landmarkImage set");
            break;
        }
    }
}

/**
 * Sets the direction of the next perspective of the landmark image to be viewed/fetched from core data for use when
 * the rotate view button is clicked again.
 * param: a string representing the current perspective of the landmark image being displayed
 */
-(void) nextRotation:(NSString *) direction {
    if ([direction isEqualToString:@"N"]) {
        rotation = @"E";
    }
    else if ([direction isEqualToString:@"E"]) {
        rotation = @"S";
    }
    else if ([direction isEqualToString:@"S"]) {
        rotation = @"W";
    }
    else {
        rotation = @"N";
    }
}

#pragma mark - play video

- (IBAction)playVideo:(id) sender{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity: des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", self.myApp.coreData.landmarkName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    Landmark *lmark = ((Landmark *) [fetchResults objectAtIndex:0]);

    [self initAndPlayVideo:lmark.landmark_video];
}


-(void) initAndPlayVideo:(NSString *)filename {
    NSString *path = [self.myApp.lib getResourceFilepath:filename];
    NSURL* url = [NSURL fileURLWithPath:path];
        MPMoviePlayerViewController* theMovie=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
        if (theMovie) {
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

- (void) playbackDidFinish:(NSNotification*)aNotification {
	NSLog(@"Playing finished!!");
    MPMoviePlayerViewController* theMovie=[aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object: theMovie];
    [self dismissMoviePlayerViewControllerAnimated];
    [theMovie.moviePlayer stop];
    theMovie.moviePlayer.initialPlaybackTime=-1.0;
    theMovie = nil;
}

- (void) viewWillDisappear:(BOOL)animated {
    NSLog(@"IntermediateView viewWillDisappear");
}

- (void) viewWillAppear:(BOOL)animated {
    NSLog(@"IntermediateView viewWillAppear");
}

- (void) viewDidDisappear:(BOOL)animated {
    NSLog(@"IntermediateView viewDidDisappear");
}

- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"IntermediateView viewDidAppear");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Prepare for segue");
}


@end
