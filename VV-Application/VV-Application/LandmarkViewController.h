//
//  LandmarkViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/7/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NinevehGL/NinevehGL.h>
#import "HomescreenViewController.h"
#import "AppDelegate.h"


@interface LandmarkViewController : UIViewController <NGLViewDelegate> {
    NGLMesh *mesh;
    NGLCamera *camera;
}

@property float rotateX;
@property float rotateY;
@property float rotateZ;

@property(nonatomic, weak) AppDelegate *myApp;


-(void) initNGL:(NSString *) fileName;

@end
