//
//  InsulaViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/8/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "HomescreenViewcontroller.h"

@interface InsulaViewController : UIViewController



@property(nonatomic, weak) IBOutlet UIScrollView *IVScroller;
@property(nonatomic, weak) IBOutlet UIView *IVScrollerContent;
@property(nonatomic, weak) IBOutlet UITextView *IVSummary;
@property(nonatomic, weak) IBOutlet UIButton *IVButton;
@property(nonatomic, weak) IBOutlet MKMapView *IVMapView;
@property(nonatomic, weak) IBOutlet UISearchBar *IVSearchBar;
@property(nonatomic, weak) IBOutlet UISlider *IVSlider;

-(IBAction)landmark_button_touch:(UIButton *)sender;


@end
