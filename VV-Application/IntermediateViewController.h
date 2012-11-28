//
//  IntermediateViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "PublicLibrary.h"

@interface IntermediateViewController : UIViewController {
}

@property (weak, nonatomic) AppDelegate *myApp;
@property (nonatomic, weak) IBOutlet UIImageView *landmarkImage;
@property NSString *rotation;


/**
 * Initialize the view
 * param: view name and bundle
 * return: self
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

/**
 * Retrieve the app delegate
 * return: App delegate instance
 */
- (AppDelegate *)myApp;

/**
 * Additional set up of view. Specifically, loads an image of the landmark being viewed.
 */
- (void)viewDidLoad;

/**
 * Function to implement actions to be taken if application memory limit is reached.
 */
- (void)didReceiveMemoryWarning;

/**
 * Fetches the default landmark image to be shown in the view and displays it.
 */
-(void) loadLandmarkImage;

/**
 * Upon the click of the "rotate view" button in the view fetches a new perspective for the landmark being viewed and
 * replaces the current perspective of the landmark image with the new one.
 * param: UIBarButtonItem i.e. "rotate view" button
 */
- (IBAction)rotateView:(UIBarButtonItem *)sender; 

/**
 * Sets the direction of the next perspective of the landmark image to be viewed/fetched from core data for use when
 * the rotate view button is clicked again.
 * param: a string representing the current perspective of the landmark image being displayed
 */
-(void) nextRotation:(NSString *) direction;

- (IBAction)playVideo:(id) sender;

#pragma mark -
#pragma mark play video
-(void) initAndPlayVideo:(NSString *) filename;
- (void) playbackDidFinish:(NSNotification*)aNotification;

@end
