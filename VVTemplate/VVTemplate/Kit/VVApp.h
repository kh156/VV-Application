//
//  VVApp.h
//  VVTemplate
//
//  Created by Kuang Han on 9/23/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VVRoot, VVLibrary;
@interface VVApp : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) VVRoot *root;
@property (nonatomic, strong) VVLibrary *lib;

@end
