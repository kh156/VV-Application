//
//  ViewController.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/5/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 * Initialize the view
 * param: view name and bundle
 * return: self
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 * Additional set up after loading the view
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"About/Credits viewDidLoad");
}

/**
 * Function to implement actions to be taken if application memory limit is reached.
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillDisappear:(BOOL)animated {
    NSLog(@"About/Credits viewWillDisappear");
}

- (void) viewWillAppear:(BOOL)animated {
    NSLog(@"About/Credits viewWillAppear");
}

- (void) viewDidDisappear:(BOOL)animated {
    NSLog(@"About/Credits viewDidDisappear");
}

- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"About/Credits viewDidAppear");
}
@end
