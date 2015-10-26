//
//  ViewController.h
//  RottenTomatoes
//
//  Created by Alex Lester on 10/20/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>

// Image types in order of detail from lowest res to highest res.
static NSString *ThumbnailImageSuffix = @"_tmb";
static NSString *ProfileImageSuffix = @"_pro";
static NSString *DetailImageSuffix = @"_det";
static NSString *OriginalImageSuffix = @"_ori";

static NSString *FlixerNewAddress = @"https://content6.flixster.com/";


@interface ViewController : UIViewController

NSString *getMoreDetailedImage(NSString* url , NSString* detailRequired);


@end

