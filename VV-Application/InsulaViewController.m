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

@synthesize tableData;
@synthesize IVMapView;
@synthesize IVSummary;
@synthesize IVButton;
@synthesize IVSearchBar;
@synthesize IVSlider;
@synthesize landmarkImage;
@synthesize myApp = _myApp;

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
    [self initTableButtons];
    [self plotMapAnnotations];
    [self setInitialMapRegion];
}

#pragma mark - TableView Data Source methods

-(void) initTableButtons {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", insulaName];
    [request setPredicate:query];
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
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] landmark_name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSString *name =[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [IVButton setTitle: name forState: UIControlStateNormal];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *des = [NSEntityDescription entityForName: @"Landmark" inManagedObjectContext:self.myApp.coreData.managedObjectContext];
        [request setEntity:des];
        NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", name];
        [request setPredicate:query];
        NSError *error = nil;
        NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
        NSString* description = ((Landmark *)[fetchResults objectAtIndex:0]).landmark_general_description;
        //NSString* imageDescription = ((Landmark *)[fetchResults objectAtIndex:0]).landmark_general_picture;
        [IVSummary setText: [self.myApp.lib getStringFromFile:description]];
        //UIImage *image = [self.myApp.lib getImageFromFile:imageDescription];
        //[self.landmarkImage setImage:image];
        [self zoomOnAnnotation: name];    
}


#pragma mark - Map Methods

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
        [self plotMapAnnotation:lmark.landmark_name address:[self.myApp.lib getStringFromFile:lmark.landmark_annotation_description] latitude:lmark.latitude.doubleValue longitude:lmark.longitude.doubleValue];
    }
}

-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude {
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithName:name address:address latitude:latitude longitude:longitude];
    [IVMapView addAnnotation:annotation];
}

-(void)setInitialMapRegion {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = 45.4333;
    mapRegion.center.longitude = 12.3167;
    mapRegion.span.latitudeDelta = 0.035;
    mapRegion.span.longitudeDelta = 0.035;
    [IVMapView setRegion:mapRegion animated: YES];
}

-(void) zoomOnAnnotation: (NSString *) name {
    for  (MapAnnotation *annotation in IVMapView.annotations) {
        NSString *title = [annotation title];
        if ([title isEqualToString: name]) {
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

-(IBAction) slider_moved:(UISlider *) sender {
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = IVMapView.region.center.latitude;
    mapRegion.center.longitude = IVMapView.region.center.longitude;
    mapRegion.span.latitudeDelta = 0.1 * sender.value + 0.01;
    mapRegion.span.longitudeDelta = 0.1 * sender.value + 0.01;
    [IVMapView setRegion:mapRegion animated: YES];
}

#pragma mark - Search Bar Action

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
            [IVSummary setText: [self.myApp.lib getStringFromFile:description]];
            [self zoomOnAnnotation: IVSearchBar.text];
        }
    }
}

#pragma mark - Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)landmark_button_touch:(UIButton *)sender {
    NSLog(@"calling landmark button touch");
    landmarkName = sender.currentTitle;
    NSLog(@"%@",landmarkName);
}


@end
