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

@synthesize insulaScroller, insulaScrollerContent;
@synthesize insulaMapView;
@synthesize landmarkSummary;
@synthesize landmarkButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.insulaScroller.contentSize = insulaScrollerContent.frame.size;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
