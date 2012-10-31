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
@synthesize rotateX, rotateY, rotateZ;

- (AppDelegate *)myApp {
    if (_myApp == NULL) {
        _myApp = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _myApp;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];
    [self initNGL: [self retrieveFileName]];
}

-(NSString *) retrieveFileName {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", landmarkName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    NSString *description = ((Landmark *) [fetchResults objectAtIndex:0]).landmark_3d;
    return description;
}

-(void) initNGL: (NSString *) fileName {
    NGLView *theView = [[NGLView alloc] initWithFrame:CGRectMake(185, 50, 650, 650)];
    theView.delegate = self;
    [self.view addSubview: theView];
    theView.contentScaleFactor = [[UIScreen mainScreen] scale];
	NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys: kNGLMeshCentralizeYes, kNGLMeshKeyCentralize, @"0.3", kNGLMeshKeyNormalize, nil];
	mesh = [[NGLMesh alloc] initWithFile:fileName settings:settings delegate:nil];
    camera = [[NGLCamera alloc] initWithMeshes:mesh, nil];
	[camera autoAdjustAspectRatio:YES animated:YES];
    [[NGLDebug debugMonitor] startWithView:theView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) drawView {
    mesh.rotateY = rotateY;
    mesh.rotateX = rotateX;
    mesh.rotateZ = rotateZ;
    [camera drawCamera];
}

-(IBAction) twoFingerRotate:(UIRotationGestureRecognizer *) sender {
    rotateZ = [sender rotation] * 180/3.14;
}

-(IBAction) panHorizontal:(UIPanGestureRecognizer *) sender {
    rotateY += [sender velocityInView: self.view].x / 100.0;
    rotateX += [sender velocityInView: self.view].y / 100.0;
}



 @end 
