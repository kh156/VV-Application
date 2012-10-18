//
//  LandmarkViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/7/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "LandmarkViewController.h"

@interface LandmarkViewController ()

@end

@implementation LandmarkViewController
@synthesize LVSliderX;
@synthesize LVSliderY;
@synthesize LVSliderZ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void) viewDidLoad {
	// Must call super to agree with the UIKit rules.
    [self initSliders];
	[super viewDidLoad];
    [self initNGL: @"house.obj"];
}

-(void) initSliders {
    [LVSliderX setMaximumValue:500];
    [LVSliderY setMaximumValue:500];
    [LVSliderZ setMaximumValue:500];
    [LVSliderX setValue: 0.5*LVSliderX.maximumValue];
    [LVSliderY setValue: 0.5*LVSliderY.maximumValue];
    [LVSliderZ setValue: 0.5*LVSliderZ.maximumValue];
}

-(void) initNGL: (NSString *) fileName {
    NGLView *theView = [[NGLView alloc] initWithFrame:CGRectMake(185, 50, 650, 650)];
    theView.delegate = self;
    [self.view addSubview: theView];
    theView.contentScaleFactor = [[UIScreen mainScreen] scale];
    
	NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys: kNGLMeshCentralizeYes, kNGLMeshKeyCentralize, @"0.3", kNGLMeshKeyNormalize, nil];
	
	mesh = [[NGLMesh alloc] initWithFile:fileName settings:settings delegate:nil];
    //mesh = [[NGLMesh alloc] initWithFile:@"insula.dae" settings:settings delegate:nil];
	camera = [[NGLCamera alloc] initWithMeshes:mesh, nil];
	[camera autoAdjustAspectRatio:YES animated:YES];
    // Starts the debug monitor.
    [[NGLDebug debugMonitor] startWithView:theView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) drawView {
    //NSLog(@"%f", LVSliderX.maximumValue);
    
    mesh.rotateY = LVSliderY.value - 0.5*LVSliderY.maximumValue;
    mesh.rotateX = LVSliderX.value - 0.5*LVSliderX.maximumValue;
    mesh.rotateZ = LVSliderZ.value - 0.5*LVSliderZ.maximumValue;
    [camera drawCamera];
    //NSLog(@"camera drawn");
}

-(IBAction) handleSwipeRight:(UISwipeGestureRecognizer *) sender {
    LVSliderY.value +=25;
    NSLog(@"swiperight");
}
-(IBAction) handleSwipeLeft:(UISwipeGestureRecognizer *) sender {
    LVSliderY.value -=25;
    NSLog(@"swipeleft");
}
-(IBAction) handleSwipeUp:(UISwipeGestureRecognizer *) sender {
    LVSliderX.value +=25;
    
    NSLog(@"swipeup");
}
-(IBAction) handleSwipeDown:(UISwipeGestureRecognizer *) sender {
    LVSliderX.value -= 25;
    NSLog(@"swipedown");
}
-(IBAction) twoFingerRotate:(UIRotationGestureRecognizer *) sender {
    LVSliderZ.value = [sender rotation] * 180/3.14;
    //NSLog(@"rotate");
}

 @end 
