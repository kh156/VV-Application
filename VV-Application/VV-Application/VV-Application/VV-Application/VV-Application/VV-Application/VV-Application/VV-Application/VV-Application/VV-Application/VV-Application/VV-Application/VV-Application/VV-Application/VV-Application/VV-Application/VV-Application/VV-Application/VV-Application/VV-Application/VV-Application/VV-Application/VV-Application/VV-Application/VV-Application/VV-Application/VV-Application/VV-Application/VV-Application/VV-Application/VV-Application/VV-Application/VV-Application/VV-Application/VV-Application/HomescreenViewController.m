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
@synthesize scroller, scrollerContent;
@synthesize HSSummary;
@synthesize HSButton;
@synthesize HSMapView;
@synthesize HSSearchBar;




- (void)viewDidLoad
{

    self.scroller.contentSize = scrollerContent.frame.size;
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
