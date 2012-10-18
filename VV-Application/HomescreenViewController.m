//
//  ViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "HomescreenViewController.h"
#import "MapAnnotation.h"


@interface HomescreenViewController ()

@end


//TODO: find better design solution to this global variable.....
NSString* insulaName;
NSString* landmarkName;

@implementation HomescreenViewController;
@synthesize HSScroller, HSScrollerContent;
@synthesize HSSummary;
@synthesize HSButton;
@synthesize HSMapView;
@synthesize HSSearchBar;
@synthesize HSSlider;


- (void)viewDidLoad {
    //HSSearchBar.prompt = @"Search for an insula";
    //[HSSlider setMaximumValue:10];
    [HSSlider setValue: 0.34];
    [self plotMapAnnotation:@"Venice" address:@"address" latitude:45.4333 longitude:12.3167];
    [self.HSScroller setContentSize: HSScrollerContent.frame.size];
    [self setInitialMapRegion];
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude {
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithName:name address:address latitude:latitude longitude:longitude];
    [HSMapView addAnnotation:annotation];
}


-(IBAction)insula_button_touch:(UIButton *)sender {
   insulaName = sender.currentTitle;
   NSLog(@"%@",insulaName);
}

-(IBAction) slider_moved:(UISlider *)sender {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = HSMapView.region.center.latitude;
    mapRegion.center.longitude = HSMapView.region.center.longitude;
    mapRegion.span.latitudeDelta = 0.1 * sender.value + 0.01;
    mapRegion.span.longitudeDelta = 0.1 * sender.value + 0.01;
    [HSMapView setRegion:mapRegion animated: YES];
}

-(void)setInitialMapRegion {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = 45.4333;
    mapRegion.center.longitude = 12.3167;
    mapRegion.span.latitudeDelta = 0.035;
    mapRegion.span.longitudeDelta = 0.035;
    [HSMapView setRegion:mapRegion animated: YES];
}

-(IBAction)insulaSearch: (UIButton *)sender {
    // if sender.text matches name of insula....
    [HSButton setTitle: HSSearchBar.text forState: UIControlStateNormal];
    //pull overview description from core data and load it into textview
    NSString* description = @"";
    //zoom in on insula in mapview!
    [HSSummary setText: description];
}



@end
