//
//  ViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


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
@property(nonatomic, weak) IBOutlet UISlider *HSSlider;

-(IBAction)insula_button_touch:(UIButton *)sender;

 

@end
