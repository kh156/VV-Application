//
//  VVRoot.m
//  VVTemplate
//
//  Created by Kuang Han on 9/23/12.
//  Copyright (c) 2012 Visualizing Venice Team. All rights reserved.
//

#import "VVRoot.h"


@implementation VVRoot
@synthesize myApp, deleteTag;

- (id)init {
    if (self = [super init]) {
        self.myApp = (VVApp *)UIApplication.sharedApplication.delegate;
    }
    return self;
}

- (void)loadView {
    UIView *baseView = [[UIView alloc] init];
    baseView.frame = CGRectMake(0, 40, 1024, 708);
    baseView.backgroundColor = [UIColor blackColor];
    self.view = baseView;

    NSLog(@"%@",self.view);
	[self handleViewSwitch:0
                     viewA:101
                     viewB:0
                   newView:@"VwWelcome"
              subAnimation:nil
                 animation:kCATransitionFade
         animationDuration:0.5f];
}

- (void)viewDidLoad {
}


- (void)handleViewSwitch :(NSInteger)actionType // 0:create view and set with tagA; 1:delete view with tagA; 2:switch views with tagA and tagB
                    viewA:(NSInteger)tagA
                    viewB:(NSInteger)tagB
                  newView:(NSString*)viewClassname // class name of the new view ()
             subAnimation:(NSString *)subanimtype
                animation:(NSString *)animtype
				 animationDuration:(float)duration { 
	[self.view setUserInteractionEnabled:NO];
	BOOL peroformAnimation;
	NSInteger subviewSize, indexOld, indexNew;
	indexNew = -1;
	indexOld = -1;
	peroformAnimation = NO;
	subviewSize = self.view.subviews.count;
	self.deleteTag = 0;
	switch (actionType) {
		case 1: {
            // Delete view
			// Find index first
			NSInteger viewIndex = [self.myApp.lib findSubviewIndexOf:self.view byTag:tagA];
			if (viewIndex >= 0) {
                // View found
				if (viewIndex == subviewSize-1) {
                    // View on the upmost level, perform animation.
					indexNew=0;
					indexOld=subviewSize-1;
					peroformAnimation=YES;
					self.deleteTag=tagA;
				}
				else {
                    [self removeView:tagA];
				}
			}
		}
			break;
			
		case 2: {
            // just switch views
			indexOld=[self.myApp.lib findSubviewIndexOf:self.view byTag:tagA];
			indexNew=[self.myApp.lib findSubviewIndexOf:self.view byTag:tagB];
			if (indexNew>=0 || indexOld>=0) {
				peroformAnimation=YES;
			}
		}
			break;
			
		default: {
            // Create view and delete old view
			if (tagB > 0) {
				self.deleteTag = tagB;
			}
			// Check if view already exists
			UIView* view = (UIView*)[self.view viewWithTag:tagA];
			if (view == nil) {
				view = [[NSClassFromString(viewClassname) alloc] init];
				if (view != nil) {
					[view setTag:tagA];
					[self.view insertSubview:view atIndex:0];
					peroformAnimation = YES;
					indexNew = 0;
					subviewSize = self.view.subviews.count;
					indexOld = subviewSize - 1;
				}
				else {
					NSLog(@"Not Find %@ class",viewClassname);
				}
			}
			else {
				peroformAnimation=YES;
				indexNew=[self.myApp.lib findSubviewIndexOf:self.view byTag:tagA];
				if (indexNew < subviewSize - 1) {
					indexOld = subviewSize - 1;
				}
			}
		}
			break;
	}

    // Perforam animation
	if (peroformAnimation) {
		[self.myApp.lib switchSubviewA:indexNew
                          withSubviewB:indexOld
                              fromView:self.view
                           inAnimation:animtype
                          subAnimation:subanimtype
                          withDuration:duration
                              onTarget:self];
	}
	
}

- (void) removeView:(NSInteger)tag{
	if (tag > 0) {
		UIView *view = (UIView*)[self.view viewWithTag:self.deleteTag];
		if (view != nil) {
			[view removeFromSuperview];
		}
	}
}

// Call back from animation
- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	[self.view setUserInteractionEnabled:YES];
	[self removeView:self.deleteTag];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    NSLog(@"interfaceOrientation: %d", interfaceOrientation);
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    return (orientation == UIInterfaceOrientationLandscapeRight);
}



@end
