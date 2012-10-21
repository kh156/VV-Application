//
//  InsulaViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/8/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "InsulaViewController.h"
#import "MapAnnotation.h"

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
        
        self.coreData = ((AppDelegate *)UIApplication.sharedApplication.delegate).coreData;
        
        // Sample code for insert and fetch data
/*
        // insert query
        Monument *entity = (Monument *)[NSEntityDescription insertNewObjectForEntityForName:@"Monument"
                                                                     inManagedObjectContext:self.coreData.managedObjectContext];
        [entity setText_intro:@"blabla"];
        [entity setImage_intro:@"imageDirectory"];
        
        // fetch query
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *des = [NSEntityDescription entityForName:@"Monument"
                                               inManagedObjectContext:self.coreData.managedObjectContext];
        [request setEntity:des];
        NSPredicate *query = [NSPredicate predicateWithFormat:@"text_intro == %@", @"blabla"];
        [request setPredicate:query];
        NSError *error = nil;
        NSArray *fetchResults = [self.coreData.managedObjectContext executeFetchRequest:request error:&error];
        if (fetchResults == nil) {
            NSLog(@"Error retrieving Reminders");
        }
        else if([fetchResults count] > 0) {
            NSLog(@"%@", ((Monument *)[fetchResults objectAtIndex:0]).text_intro);
        }
*/
        
    }
    return self;
}

- (void)viewDidLoad {
    [self.IVSlider setValue: 0.34];
    [self plotMapAnnotation:@"Venice" address:@"address" latitude:45.4333 longitude:12.3167];
    [self.IVScroller setContentSize: IVScrollerContent.frame.size];
    [self setInitialMapRegion];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude {
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithName:name address:address latitude:latitude longitude:longitude];
    [IVMapView addAnnotation:annotation];
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

-(IBAction)landmarkSearch: (UIBarButtonItem *)sender {
    // if sender.text matches name of insula....
    [IVButton setTitle: IVSearchBar.text forState: UIControlStateNormal];
    //pull overview description from core data and load it into textview
    NSString* description = @"";
    [IVSummary setText: description];
    [self zoomOnAnnotation];
}

-(void) zoomOnAnnotation {
    for  (MapAnnotation *annotation in IVMapView.annotations) {
        NSString *name = [annotation title];
        if ([name isEqualToString: IVSearchBar.text]) {
            //TODO: MAKE SURE NAME NOT EQUAL TO Current Location!
            NSLog(@"%@", @"match!");
            MKCoordinateRegion mapRegion;
            mapRegion.center.latitude = annotation.coordinate.latitude;
            mapRegion.center.longitude = annotation.coordinate.longitude;
            mapRegion.span.latitudeDelta = 0.0005;
            mapRegion.span.longitudeDelta = 0.0005;
            [IVSlider setValue: 0.0005/0.1];
            [IVMapView setRegion:mapRegion animated: YES];
            
        }
    }
}

@end
