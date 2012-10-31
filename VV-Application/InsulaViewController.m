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
@synthesize myApp = _myApp;
@synthesize IVButton1, IVButton2, IVButton3, IVButton4, IVButton5, IVButton6, IVButton7, IVButton8, IVButton9, IVButton10;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (AppDelegate *)myApp {
    if (_myApp == NULL) {
        _myApp = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _myApp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.IVSlider setValue: 0.34];
    [self initLandmarkButtons];
    [self plotMapAnnotations];
    [self.IVScroller setContentSize: IVScrollerContent.frame.size];
    [self setInitialMapRegion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) plotMapAnnotations {
   // NSLog(@"plotting map annotations insula");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", insulaName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    Landmark *lmark;
    for (lmark in fetchResults) {
        [self plotMapAnnotation:lmark.landmark_name address:lmark.landmark_annotation_description latitude:lmark.latitude.doubleValue longitude:lmark.longitude.doubleValue];
    }
}
    
    //lmark = [fetchResults objectAtIndex:0];
   // UIImage* image = [self.myApp.lib getImageFromFile:lmark.landmark_general_picture];
    //NSString* string = [self.myApp.lib getStringFromFile:lmark.landmark_general_description]; 

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


-(NSArray *) landmarkButtonArray {
    NSArray *landmarkButtons =  [[NSArray alloc] initWithObjects: IVButton1, IVButton2, IVButton3, IVButton4, IVButton5, IVButton5, IVButton6, IVButton7, IVButton8, IVButton9, IVButton10, nil];
    return landmarkButtons;
}

-(void) initLandmarkButtons {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", insulaName];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    int count = 0;
    NSArray *landmarkButtons = [self landmarkButtonArray];
    for (Landmark *lmark in fetchResults) {
        //TODO: Add error thing here if array size too small or big....
        [landmarkButtons[count] setTitle: lmark.landmark_name forState:UIControlStateNormal];
    }
}

-(IBAction)landmarkSearch: (UIBarButtonItem *)sender {
    for (MapAnnotation *annotation in IVMapView.annotations) {
        NSString *name = [annotation title];
        if ([name isEqualToString: IVSearchBar.text]) {
            [IVButton setTitle: IVSearchBar.text forState: UIControlStateNormal];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self. myApp.coreData.managedObjectContext];
            [request setEntity:des];
            NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", name];
            [request setPredicate:query];
            NSError *error = nil;
            NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
            //TODO: check if results is null
            NSString* description = ((Landmark *)[fetchResults objectAtIndex:0]).landmark_general_description;
            [IVSummary setText: description];
            [self zoomOnAnnotation];
        }
    }
}

-(void) zoomOnAnnotation {
    for  (MapAnnotation *annotation in IVMapView.annotations) {
        NSString *name = [annotation title];
        if ([name isEqualToString: IVSearchBar.text]) {
            //TODO: MAKE SURE NAME NOT EQUAL TO "Current Location"!
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
