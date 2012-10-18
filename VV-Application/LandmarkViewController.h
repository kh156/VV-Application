//
//  LandmarkViewController.h
//  VV-Application
//
//  Created by Nicholas Gordon on 10/7/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NinevehGL/NinevehGL.h>


@interface LandmarkViewController : UIViewController <NGLViewDelegate> {
    NGLMesh *mesh;
    NGLCamera *camera;
}

@property(nonatomic, weak) IBOutlet UISlider *LVSliderX;
@property(nonatomic, weak) IBOutlet UISlider *LVSliderY;
@property(nonatomic, weak) IBOutlet UISlider *LVSliderZ;

-(void) initNGL:(NSString *) fileName;

@end
