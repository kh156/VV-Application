//
//  ViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "InsulaViewController.h"


@interface HomescreenViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIScrollView *HSScroller;
@property(nonatomic, weak) IBOutlet UIView *HSScrollerContent;
@property(nonatomic, weak) IBOutlet UITextView *HSSummary;
@property(nonatomic, weak) IBOutlet UIButton *HSButton;
@property(nonatomic, weak) IBOutlet UISearchBar *HSSearchBar;
@property(nonatomic, weak) IBOutlet MKMapView *HSMapView;
@property(nonatomic, weak) IBOutlet UISlider *HSSlider;
@property(nonatomic, weak) IBOutlet InsulaViewController* insulaViewController;

-(IBAction)insula_button_touch:(UIButton *)sender;
 

@end
