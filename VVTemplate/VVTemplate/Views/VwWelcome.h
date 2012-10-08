//
//  VwWelcome.h
//  VVTemplate
//
//  Created by Kuang Han on 9/24/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//

#import "VVHeader.h"

@interface VwWelcome : UIView

@property (nonatomic, weak) VVApp* myApp;
@property (nonatomic, strong) IBOutlet UIView* view;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIView* scrollViewContent;

- (IBAction)nextView:(UIButton*)sender;
@end
