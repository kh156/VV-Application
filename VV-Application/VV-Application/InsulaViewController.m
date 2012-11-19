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
@synthesize dates;
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
    NSLog(@"insula = %@, landmark = %@", insulaName, landmarkName);
    [super viewDidLoad];
    [self initTableButtons];
    [self plotMapAnnotations];
    [self setInitialMapRegion];
    [IVSlider setEnabled:NO];
    
    //prompt user for search bar input
    [IVSearchBar setPlaceholder:@"Search for a Landmark!"];
    [IVSearchBar placeholder];
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
    [IVSlider setEnabled:YES];
    dates = [[NSMutableArray alloc] init];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name = %@", landmarkName];
    NSArray *fetchResults = [self entity:@"Landmark" predicate: query];
    Landmark *lmark = ((Landmark *) [fetchResults objectAtIndex:0]);
    for (Timeslot *slot in lmark.timeslots) {
        [dates addObject:slot.year];
        //NSLog(@"%@", slot.year);
    }
    IVSlider.continuous = YES;
    [IVSlider setMinimumValue:0];
    [IVSlider setMaximumValue:((float)[dates count] - 1)];
    
    int width = IVSlider.frame.size.width;
    //origin is top left of slider
    int startx = IVSlider.frame.origin.x;
    int starty = IVSlider.frame.origin.y;
    int count = 0;
    [dates sortUsingSelector:@selector(compare:)];
    for (NSNumber *num in dates) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startx + count * (width/([dates count]-1)) - 20, starty - 20, 40, 20) ];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = self.view.backgroundColor;
        label.font = [UIFont fontWithName:@"Times New Roman Bold" size:(12.0)];
        [self.view addSubview:label];
        label.text = [NSString stringWithFormat: @"%d", [num intValue]];
        count++;
    }
    [IVSlider setValue:IVSlider.maximumValue];
    [IVSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self valueChanged:IVSlider];
}


-(void) valueChanged:(UISlider *) sender {
    NSUInteger index = (NSUInteger)(IVSlider.value + 0.5); //round number
    [IVSlider setValue:index animated:NO];
    NSNumber *date = [dates objectAtIndex:index];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name = %@", landmarkName];
    NSArray *fetchResults = [self entity:@"Landmark" predicate:query];
    Landmark *lmark = ((Landmark *) [fetchResults objectAtIndex:0]);
    for (Timeslot *timeslot in lmark.timeslots) {
        if ([timeslot.year isEqualToNumber:date]) {
            [IVSummary setText:[self.myApp.lib getStringFromFile:timeslot.landmark_general_description]];
            UIImage *img = [UIImage imageNamed:timeslot.landmark_general_picture];
            [landmarkImage setImage:img];
            break;
        };
    }
}

#pragma mark - TableView Data Source methods

-(void) initTableButtons {
    tableData = [self entity:@"Landmark" predicate: nil];
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
        landmarkName = name;
        [self setUpSlider];
        [IVButton setTitle: name forState: UIControlStateNormal];
        //NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", name];
        //NSArray *fetchResults = [self entity:@"Landmark" predicate:query];
        //NSString* description = ((Landmark *)[fetchResults objectAtIndex:0]).landmark_general_description;
        //[IVSummary setText: [self.myApp.lib getStringFromFile:description]];
        //NSString* imageDescription = ((Landmark *)[fetchResults objectAtIndex:0]).landmark_general_picture;
        //UIImage *img = [UIImage imageNamed:imageDescription];
        //[landmarkImage setImage:img];
        //TODO: resize image?
        [self zoomOnAnnotation: name];
}

#pragma mark - Map Methods

-(void) plotMapAnnotations {
    // NSLog(@"plotting map annotations insula");
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", insulaName];
    NSArray *fetchResults = [self entity:@"Landmark" predicate:query];
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
            landmarkName = IVSearchBar.text;
            [self setUpSlider];
            //NSPredicate *query = [NSPredicate predicateWithFormat:@"landmark_name == %@", name];
            //NSArray *fetchResults = [self entity:@"Landmark" predicate:query];
            //TODO: check if results is null
            //NSString* description = ((Landmark *)[fetchResults objectAtIndex:0]).landmark_general_description;
            //[IVSummary setText: [self.myApp.lib getStringFromFile:description]];
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
