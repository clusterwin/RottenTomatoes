//
//  MovieDetailsViewController.h
//  RottenTomatoes
//
//  Created by Alex Lester on 10/23/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (strong, nonatomic) NSDictionary *movie;

@end
