//
//  InsulaViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/8/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "HomescreenViewController.h"
#import "AppDelegate.h"

@interface InsulaViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *tableData;
}

@property (nonatomic, retain) NSArray *tableData;
@property(nonatomic, weak) IBOutlet UITextView *IVSummary;
@property(nonatomic, weak) IBOutlet UIButton *IVButton;
@property(nonatomic, weak) IBOutlet MKMapView *IVMapView;
@property(nonatomic, weak) IBOutlet UISearchBar *IVSearchBar;
@property(nonatomic, weak) IBOutlet UISlider *IVSlider;
@property(nonatomic, weak) AppDelegate *myApp;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
-(AppDelegate *) myApp;
-(void)viewDidLoad;
-(void)initTableButtons;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void) plotMapAnnotations;
-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude;
-(void)setInitialMapRegion;
-(void) zoomOnAnnotation: (NSString *) name;
-(IBAction) slider_moved:(UISlider *) sender;
-(IBAction)landmarkSearch: (UIBarButtonItem *)sender;
-(void)didReceiveMemoryWarning;
-(IBAction)landmark_button_touch:(UIButton *)sender;

@end
