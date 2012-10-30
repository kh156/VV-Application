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

@interface InsulaViewController : UIViewController 

@property(nonatomic, weak) IBOutlet UIScrollView *IVScroller;
@property(nonatomic, weak) IBOutlet UIView *IVScrollerContent;
@property(nonatomic, weak) IBOutlet UITextView *IVSummary;
@property(nonatomic, weak) IBOutlet UIButton *IVButton;
@property(nonatomic, weak) IBOutlet MKMapView *IVMapView;
@property(nonatomic, weak) IBOutlet UISearchBar *IVSearchBar;
@property(nonatomic, weak) IBOutlet UISlider *IVSlider;
@property(nonatomic, weak) IBOutlet UIButton *IVButton1;
@property(nonatomic, weak) IBOutlet UIButton *IVButton2;
@property(nonatomic, weak) IBOutlet UIButton *IVButton3;
@property(nonatomic, weak) IBOutlet UIButton *IVButton4;
@property(nonatomic, weak) IBOutlet UIButton *IVButton5;
@property(nonatomic, weak) IBOutlet UIButton *IVButton6;
@property(nonatomic, weak) IBOutlet UIButton *IVButton7;
@property(nonatomic, weak) IBOutlet UIButton *IVButton8;
@property(nonatomic, weak) IBOutlet UIButton *IVButton9;
@property(nonatomic, weak) IBOutlet UIButton *IVButton10;

@property(nonatomic, weak) AppDelegate *myApp;

-(IBAction)landmark_button_touch:(UIButton *)sender;
-(IBAction) slider_moved:(UISlider *)sender;
-(void)setInitialMapRegion;
-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude;
-(IBAction)landmarkSearch: (UIBarButtonItem *)sender;
-(void) zoomOnAnnotation;
-(void) plotMapAnnotations;
-(void) initLandmarkButtons;

@end
