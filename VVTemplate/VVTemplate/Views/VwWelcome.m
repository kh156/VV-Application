//
//  VwWelcome.m
//  VVTemplate
//
//  Created by Kuang Han on 9/24/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//

#import "VwWelcome.h"

@implementation VwWelcome

@synthesize myApp, view, scrollView, scrollViewContent;

- (id)init {
    if (self = [super init]) {
        self.myApp = (VVApp *)UIApplication.sharedApplication.delegate;
        
        [[NSBundle mainBundle] loadNibNamed:@"VwWelcome" owner:self options:nil];
        self.frame = self.view.frame;
        [self addSubview:self.view];
        
        self.scrollView.contentSize = self.scrollViewContent.frame.size;
        [self.scrollView addSubview:self.scrollViewContent];
        [self.view addSubview:self.scrollView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
	
    [[NSBundle mainBundle] loadNibNamed:@"VwWelcome" owner:self options:nil];
    [self addSubview:self.view];
    self.frame = self.view.frame;
}

- (IBAction)nextView:(UIButton*)sender {
    [myApp.root handleViewSwitch:0
                           viewA:102
                           viewB:0
                         newView:@"VwFirstPage"
                    subAnimation:kCATransitionFromLeft
                       animation:kCATransitionFade
               animationDuration:0.5f];
}

@end
