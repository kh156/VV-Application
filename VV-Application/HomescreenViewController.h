//
//  ViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreData.h"
#import "AppDelegate.h"
#import "PublicLibrary.h"


@interface HomescreenViewController : UIViewController 

//TODO: find better design solution to global variables....
extern NSString* insulaName;
extern NSString* landmarkName;

@property(nonatomic, weak) IBOutlet UIScrollView *HSScroller;
@property(nonatomic, weak) IBOutlet UIView *HSScrollerContent;
@property(nonatomic, weak) IBOutlet UITextView *HSSummary;
@property(nonatomic, weak) IBOutlet UIButton *HSButton;
@property(nonatomic, weak) IBOutlet UISearchBar *HSSearchBar;
@property(nonatomic, weak) IBOutlet MKMapView *HSMapView;
@property(nonatomic, weak) PublicLibrary *myLibrary;
@property(nonatomic, weak) IBOutlet UISlider *HSSlider;
@property(nonatomic, weak) IBOutlet UIButton *HSButton1;
@property(nonatomic, weak) IBOutlet UIButton *HSButton2;
@property(nonatomic, weak) IBOutlet UIButton *HSButton3;
@property(nonatomic, weak) IBOutlet UIButton *HSButton4;
@property(nonatomic, weak) IBOutlet UIButton *HSButton5;
@property(nonatomic, weak) IBOutlet UIButton *HSButton6;
@property(nonatomic, weak) IBOutlet UIButton *HSButton7;
@property(nonatomic, weak) IBOutlet UIButton *HSButton8;
@property(nonatomic, weak) IBOutlet UIButton *HSButton9;
@property(nonatomic, weak) IBOutlet UIButton *HSButton10;

@property(nonatomic, weak) AppDelegate *myApp;


-(IBAction)insula_button_touch:(UIButton *)sender;
-(IBAction) slider_moved:(UISlider *)sender;
-(void)setInitialMapRegion;
-(void) plotMapAnnotation: (NSString *) name address:(NSString *) address latitude:(double) latitude longitude:(double) longitude;
-(IBAction)insulaSearch:(UIBarButtonItem *) sender;
-(void) zoomOnAnnotation;
-(void) plotMapAnnotations;
-(void) initInsulaButtons;



 

@end
