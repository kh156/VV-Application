//
//  VwWelcome.m
//  VVTemplate
//
//  Created by Kuang Han on 9/24/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//


#import "VwFirstPage.h"


@implementation VwFirstPage
@synthesize myApp;


- (id)init {
    if (self = [super init]) {
		[self setMyApp:(VVApp *)UIApplication.sharedApplication.delegate];
        
        [self setFrame:CGRectMake(0, 0, self.myApp.root.view.frame.size.width, self.myApp.root.view.frame.size.height)];
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


- (void) initView {
    UILabel* label = [[UILabel alloc] init];
    label.text = @"First Page";
    label.font = [UIFont fontWithName:@"Helvetica" size:90];
//    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.2 green:0.45 blue:0.25 alpha:1.0];
    label.frame = CGRectMake(248, 159, 451, 251);
    [self addSubview:label];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTintColor:[UIColor blueColor]];
    button.frame = CGRectMake(40, 40, 118, 57);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void) back {
    [myApp.root handleViewSwitch:1
                           viewA:102
                           viewB:0
                         newView:nil
                    subAnimation:kCATransitionFromLeft
                       animation:kCATransitionPush
               animationDuration:0.5f];
}

@end
