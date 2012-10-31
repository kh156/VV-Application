//
//  ViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "HomescreenViewController.h"
#import "MapAnnotation.h"
#import "Insula.h"


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
@synthesize HSButton1, HSButton2, HSButton3, HSButton4, HSButton5, HSButton6, HSButton7, HSButton8, HSButton9, HSButton10;
@synthesize myApp = _myApp;

- (void)viewDidLoad {
    //HSSearchBar.prompt = @"Search for an insula";
    //[HSSlider setMaximumValue:10];
    [HSSlider setValue: 0.34];
    [self plotMapAnnotations];
    [self initInsulaButtons];
    [self.HSScroller setContentSize: HSScrollerContent.frame.size];
    [self setInitialMapRegion];
    [super viewDidLoad];
}

- (AppDelegate *)myApp {
    if (_myApp == NULL) {
        _myApp = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _myApp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSArray *) insulaButtonArray {
    NSArray *insulaButtons =  [[NSArray alloc] initWithObjects: HSButton1, HSButton2, HSButton3, HSButton4, HSButton5, HSButton5, HSButton6, HSButton7, HSButton8, HSButton9, HSButton10, nil];
    return insulaButtons;
}

-(void) initInsulaButtons {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"%@", fetchResults);
    int count = 0;
    NSArray *insulaButtons = [self insulaButtonArray];
    for (Insula *insulaData in fetchResults) {
        //TODO: Add error thing here if array size too small or big....
        [insulaButtons[count] setTitle: insulaData.insula_name forState:UIControlStateNormal];
    }
}
 
-(void) plotMapAnnotations {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:NULL];
    Insula *insulaData;
    for (insulaData in fetchResults) {
//        NSLog(@"%@", insulaData);
        NSString *generalDes = [self.myApp.lib getStringFromFile:insulaData.insula_annotation_description];
        NSLog(@"generalDes = %@", generalDes);
        //TODO: generalDes = NULL?
        [self plotMapAnnotation:insulaData.insula_name address:generalDes latitude:insulaData.latitude.doubleValue longitude:insulaData.longitude.doubleValue];
    }
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
    mapRegion.span.latitudeDelta = 0.1 * sender.value;
    mapRegion.span.longitudeDelta = 0.1 * sender.value;
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

-(IBAction)insulaSearch: (UIBarButtonItem *)sender {
    for (MapAnnotation *annotation in HSMapView.annotations) {
        NSString *name = [annotation title];
        if ([name isEqualToString: HSSearchBar.text]) {
            [HSButton setTitle: HSSearchBar.text forState: UIControlStateNormal];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
            [request setEntity:des];
            NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", name];
            [request setPredicate:query];
            NSError *error = nil;
             NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
            //TODO: check if results is null
            NSString* description = ((Insula *)[fetchResults objectAtIndex:0]).insula_general_description;
            NSString* generalDes = [self.myApp.lib getStringFromFile:description];
            [HSSummary setText: generalDes];
            [self zoomOnAnnotation];
        }
    }
}

-(void) zoomOnAnnotation {
    for  (MapAnnotation *annotation in HSMapView.annotations) {
        NSString *name = [annotation title];
        if ([name isEqualToString: HSSearchBar.text]) {
            //TODO: MAKE SURE NAME NOT EQUAL TO Current Location!
            MKCoordinateRegion mapRegion;
            mapRegion.center.latitude = annotation.coordinate.latitude;
            mapRegion.center.longitude = annotation.coordinate.longitude;
            mapRegion.span.latitudeDelta = 0.0005;
            mapRegion.span.longitudeDelta = 0.0005;
            [HSSlider setValue: 0.0005/0.1];
            [HSMapView setRegion:mapRegion animated: YES];
        }
    }
}



@end
