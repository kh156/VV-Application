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
@synthesize insulaImage;
@synthesize myApp = _myApp;
@synthesize dates;

- (AppDelegate *)myApp {
    if (_myApp == NULL) {
        _myApp = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _myApp;
}

- (void)viewDidLoad {
     NSLog(@"insula = %@, landmark = %@", insulaName, landmarkName);
    [super viewDidLoad];
    [self initTableButtons];
    [self plotMapAnnotations];
    [self setInitialMapRegion];
    [HSSlider setEnabled:NO];
    [HSSearchBar setPlaceholder:@"Search for an Insula!"];
    [HSSearchBar placeholder];
}

#pragma mark - fetch from core data utility method

-(NSArray *) entity:(NSString *) entity predicate: (NSPredicate *) query {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:entity inManagedObjectContext:self.myApp.coreData.managedObjectContext];
    [request setEntity:des];
    [request setPredicate:query];
    NSError *error = nil;
    NSArray *fetchResults = [self.myApp.coreData.managedObjectContext executeFetchRequest:request error:&error];
    return fetchResults;
}

#pragma mark - Slider methods, TimeChange methods

-(void) setUpSlider {
    [HSSlider setEnabled:YES];
    dates = [[NSMutableArray alloc] init];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name = %@", insulaName];
    NSArray *fetchResults = [self entity:@"Insula" predicate: query];
    Insula *insula = ((Insula *) [fetchResults objectAtIndex:0]);
    for (Timeslot *slot in insula.timeslots) {
        [dates addObject:[NSNumber numberWithInt:slot.year.intValue]];
        NSLog(@"%@", [NSNumber numberWithInt:slot.year.intValue]);
    }
    HSSlider.continuous = YES;
    [HSSlider setMinimumValue:0];
    [HSSlider setMaximumValue:((float)[dates count] - 1)];
    
    /*int width = HSSlider.frame.size.width;
    int height = HSSlider.frame.size.height;
    //origin is top left of slider
    int startx = HSSlider.frame.origin.x;
    int starty = HSSlider.frame.origin.y;
    int count = 1;
    for (NSNumber *num in dates) {
        UILabel *label = [[UILabel alloc] init];
        [label setText:[num stringValue]];
        CGRect *position = CGRectMake(startx + count * (width/([dates count]-1)), starty - height - 2, 10, 5);
        [label setFrame:position];*/
        
    //}
    [HSSlider setValue:HSSlider.maximumValue];
    [HSSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void) valueChanged:(UISlider *) sender {
    NSUInteger index = (NSUInteger)(HSSlider.value + 0.5); //round number
    [HSSlider setValue:index animated:NO];
    NSNumber *date = [dates objectAtIndex:index];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name = %@", insulaName];
    NSArray *fetchResults = [self entity:@"Insula" predicate:query];
    Insula *insula = ((Insula *) [fetchResults objectAtIndex:0]);
    for (Timeslot *timeslot in insula.timeslots) {
        if ([timeslot.year isEqualToNumber:date]) {
            //timeslot description set
            //set timeslot image
            break;
        };
    }
}

//TODO: make this do stuff
-(MKAnnotationView *) mapview:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *myPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    myPin.pinColor = MKPinAnnotationColorRed;
    UIImage *image = [self.myApp.lib getImageFromFile:@"VisualizingVeniceLogo.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    myPin.rightCalloutAccessoryView = imageView;
    myPin.draggable = NO;
    myPin.highlighted = YES;
    myPin.animatesDrop = TRUE;
    myPin.canShowCallout = YES;
    return myPin;
}

#pragma mark - TableView Data Source methods

-(void) initTableButtons {
    tableData = [self entity:@"Insula" predicate: nil];
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
    insulaName = name;
    [HSButton setTitle: name forState: UIControlStateNormal];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", name];
    NSArray *fetchResults = [self entity:@"Insula" predicate:query];
    NSString* description = ((Insula *)[fetchResults objectAtIndex:0]).insula_general_description;
    [HSSummary setText: [self.myApp.lib getStringFromFile:description]];
    [self zoomOnAnnotation: name];
    
    NSString* imageDescription = ((Insula *)[fetchResults objectAtIndex:0]).insula_general_picture;
    UIImage *img = [UIImage imageNamed:imageDescription];
    [insulaImage setImage:img];
    [self zoomOnAnnotation: name];
    [self setUpSlider];
}

#pragma mark - Map Methods

-(void) plotMapAnnotations {
    NSArray *fetchResults = [self entity:@"Insula" predicate:nil];
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
            NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", name];
            NSArray *fetchResults = [self entity:@"Insula" predicate:query];
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
