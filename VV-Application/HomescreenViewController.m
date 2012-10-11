//
//  ViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "HomescreenViewController.h"

@interface HomescreenViewController ()

@end

@implementation HomescreenViewController;
@synthesize HSScroller, HSScrollerContent;
@synthesize HSSummary;
@synthesize HSButton;
@synthesize HSMapView;
@synthesize HSSearchBar;
@synthesize HSSlider;
@synthesize insulaViewController; 

- (void)viewDidLoad
{

    self.HSScroller.contentSize = HSScrollerContent.frame.size;
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)insula_button_touch:(UIButton *)sender {
    insulaViewController.insulaName = sender.currentTitle;
    NSLog(@"%@",insulaViewController.insulaName);
}



@end
