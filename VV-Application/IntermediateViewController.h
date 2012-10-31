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

@interface IntermediateViewController : UIViewController

@property (weak, nonatomic) AppDelegate *myApp;
@property (nonatomic, weak) IBOutlet UIImageView *landmarkImage;
@property (weak, nonatomic) PublicLibrary *myLibrary;

#pragma mark -
#pragma mark play video
-(void) playVideo:(NSString *) filename;
- (void) playbackDidFinish:(NSNotification*)aNotification;

@end
