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
	[super viewDidLoad];
    [self initNGL: @"house.obj"];
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
    mesh.rotateY += 1;
    //mesh.rotateX += 2.5;
    //mesh.rotateZ += 1.25;
    [camera drawCamera];
    //NSLog(@"camera drawn");
    
}

@end
