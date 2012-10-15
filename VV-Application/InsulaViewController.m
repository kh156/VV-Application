//
//  InsulaViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/8/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "InsulaViewController.h"

@interface InsulaViewController ()

@end



@implementation InsulaViewController

@synthesize IVScroller, IVScrollerContent;
@synthesize IVMapView;
@synthesize IVSummary;
@synthesize IVButton;
@synthesize IVSearchBar;
@synthesize IVSlider;
@synthesize coreData = _coreData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.coreData = ((AppDelegate *)UIApplication.sharedApplication.delegate).coreData;
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.IVScroller.contentSize = IVScrollerContent.frame.size;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)landmark_button_touch:(UIButton *)sender {
    landmarkName = sender.currentTitle;
    NSLog(@"%@",landmarkName);
}

@end
