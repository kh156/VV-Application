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
@synthesize HSButton1, HSButton2, HSButton3, HSButton4, HSButton5, HSButton6, HSButton7, HSButton8, HSButton9, HSButton10;

- (void)viewDidLoad {
    //HSSearchBar.prompt = @"Search for an insula";
    //[HSSlider setMaximumValue:10];
    [HSSlider setValue: 0.34];
    [self plotMapAnnotation:@"Venice" address:@"description of Venice blah blah blah" latitude:45.4333 longitude:12.3167];
    //[self plotMapAnnotations];
    //[self initInsulaButtons];
    [self.HSScroller setContentSize: HSScrollerContent.frame.size];
    [self setInitialMapRegion];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSArray *) insulaButtonArray {
    NSArray *insulaButtons =  [[NSArray alloc] initWithObjects: HSButton1, HSButton2, HSButton3, HSButton4, HSButton5, HSButton5, HSButton6, HSButton7, HSButton8, HSButton9, HSButton10, nil];
    return insulaButtons;
}

/*-(void) initInsulaButtons {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName: @"Insula" inManagedObjectContext: self.coreData.managedObjectContext];
    [request setEntity:des];
    NSError *error = nil;
    NSArray *fetchResults = [self.coreData.managedObjectContext executeFetchRequest:request error:&error];
    int count = 0;
    NSArray *insulaButtons = [self insulaButtonArray];
    for (Landmark *lmark in fetchResults) {
        //Add error thing here if array size too small or big....
        [insulaButtons[count] setTitle: [lmark getInsulaName] forState:UIControlStateNormal];
    }
}*/

/*
-(void) plotMapAnnotations {
 NSFetchRequest *request = [[NSFetchRequest alloc] init];
 NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula" inManagedObjectContext:self.coreData.managedObjectContext];
 [request setEntity:des];
 //    NSPredicate *query = [NSPredicate predicateWithFormat:@""];
 //    [request setPredicate:NULL];
 NSError *error = nil;
 NSArray *fetchResults = [self.coreData.managedObjectContext executeFetchRequest:request error:&error];
 for (Landmark *lmark in fetchResults) {
 plotMapAnnotation: [lmark getName] address: [lmark getDescription] latitude: [lmark getLatitude] longitude: [lmark getLongitude];
 }
 } */

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
    // if sender.text matches name of insula....
    for (MapAnnotation *annotation in HSMapView.annotations) {
        NSString *name = [annotation title];
        if ([name isEqualToString: HSSearchBar.text]) {
            [HSButton setTitle: HSSearchBar.text forState: UIControlStateNormal];
    
            /* NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula"inManagedObjectContext:self.coreData.managedObjectContext];
            [request setEntity:des];
            NSPredicate *query = [NSPredicate predicateWithFormat:name];
            [request setPredicate:query;
            NSError *error = nil;
            NSArray *fetchResults = [self.coreData.managedObjectContext executeFetchRequest:request error:&error];
            
            //pull overview description from core data and load it into textview
            NSString* description = [fetchResults[0] getDescription]; */
            //[HSSummary setText: description];
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
