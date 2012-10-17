//
//  InsulaViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/8/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "InsulaViewController.h"

@interface InsulaViewController ()

@end



@implementation InsulaViewController

@synthesize IVScroller, IVScrollerContent;
@synthesize IVMapView;
@synthesize IVSummary;
@synthesize IVButton;
@synthesize IVSearchBar;
@synthesize IVSlider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [self.IVSlider setValue: 0.34];
    [self.IVScroller setContentSize: IVScrollerContent.frame.size];
    [self setInitialMapRegion];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)landmark_button_touch:(UIButton *)sender {
    landmarkName = sender.currentTitle;
    NSLog(@"%@",landmarkName);
}

-(IBAction) slider_moved:(UISlider *) sender {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = IVMapView.region.center.latitude;
    mapRegion.center.longitude = IVMapView.region.center.longitude;
    mapRegion.span.latitudeDelta = 0.1 * sender.value + 0.01;
    mapRegion.span.longitudeDelta = 0.1 * sender.value + 0.01;
    [IVMapView setRegion:mapRegion animated: YES];
}

-(void)setInitialMapRegion {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = 45.4333;
    mapRegion.center.longitude = 12.3167;
    mapRegion.span.latitudeDelta = 0.035;
    mapRegion.span.longitudeDelta = 0.035;
    [IVMapView setRegion:mapRegion animated: YES];
}

@end
