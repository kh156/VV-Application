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

-(IBAction)landmark_button_touch:(UIButton *)sender;
-(IBAction) slider_moved:(UISlider *)sender;
-(void)setInitialMapRegion;
-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude;
-(IBAction)landmarkSearch: (UIBarButtonItem *)sender;
-(void) zoomOnAnnotation;
-(void) plotMapAnnotations;

@end
