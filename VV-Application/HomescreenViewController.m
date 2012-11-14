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
@synthesize tableData;
@synthesize HSSummary;
@synthesize HSButton;
@synthesize HSMapView;
@synthesize HSSearchBar;
@synthesize HSSlider;
@synthesize myApp = _myApp;

- (AppDelegate *)myApp {
    if (_myApp == NULL) {
        _myApp = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _myApp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableButtons];
    [self plotMapAnnotations];
    [self setInitialMapRegion];
    //HSSearchBar.prompt = @"Search for an insula";
    //[HSSlider setMaximumValue:10];
    //[HSSlider setValue: 0.34];
}

#pragma mark - TableView Data Source methods

-(void) initTableButtons {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSError *error = nil;
    tableData = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell 1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"Cell 1"];
    }
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] insula_name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name =[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [HSButton setTitle: name forState: UIControlStateNormal];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName: @"Insula" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", name];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    NSString* description = ((Insula *)[fetchResults objectAtIndex:0]).insula_general_description;
    [HSSummary setText: [self.myApp.lib getStringFromFile:description]];
    [self zoomOnAnnotation: name];
}

#pragma mark - Map Methods

-(void) plotMapAnnotations {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:NULL];
    Insula *insulaData;
    for (insulaData in fetchResults) {
        NSString *generalDes = [self.myApp.lib getStringFromFile:insulaData.insula_annotation_description];
        //NSLog(@"generalDes = %@", generalDes);
        //TODO: generalDes = NULL?
        [self plotMapAnnotation:insulaData.insula_name address:generalDes latitude:insulaData.latitude.doubleValue longitude:insulaData.longitude.doubleValue];
    }
}

-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude {
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithName:name address:address latitude:latitude longitude:longitude];
    [HSMapView addAnnotation:annotation];
}

-(void)setInitialMapRegion {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = 45.4333;
    mapRegion.center.longitude = 12.3167;
    mapRegion.span.latitudeDelta = 0.035;
    mapRegion.span.longitudeDelta = 0.035;
    [HSMapView setRegion:mapRegion animated: YES];
}

-(void) zoomOnAnnotation: (NSString *) name {
    for  (MapAnnotation *annotation in HSMapView.annotations) {
        NSString *title = [annotation title];
        if ([title isEqualToString: name]) {
            //TODO: MAKE SURE NAME NOT EQUAL TO "Current Location"!
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

-(IBAction) slider_moved:(UISlider *)sender {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = HSMapView.region.center.latitude;
    mapRegion.center.longitude = HSMapView.region.center.longitude;
    mapRegion.span.latitudeDelta = 0.1 * sender.value;
    mapRegion.span.longitudeDelta = 0.1 * sender.value;
    [HSMapView setRegion:mapRegion animated: YES];
}

#pragma mark - Search Bar Action

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
            [self zoomOnAnnotation: HSSearchBar.text];
        }
    }
}

#pragma mark - Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(IBAction)insula_button_touch:(UIButton *)sender {
   insulaName = sender.currentTitle;
   NSLog(@"%@",insulaName);
}


@end
