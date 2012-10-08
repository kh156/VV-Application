//
//  VVRoot.h
//  VVTemplate
//
//  Created by Kuang Han on 9/23/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//

#import "VVHeader.h"

@interface VVRoot : UIViewController

@property (nonatomic, weak) VVApp *myApp;
@property (nonatomic, readwrite) NSInteger deleteTag;


- (void)handleViewSwitch :(NSInteger)actionType
                    viewA:(NSInteger)tagA
                    viewB:(NSInteger)tagB
                  newView:(NSString*)viewClassname
             subAnimation:(NSString *)subanimtype
                animation:(NSString *)animtype
				 animationDuration:(float)duration;

- (void) removeView:(NSInteger)tag;
@end
