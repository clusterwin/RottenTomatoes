//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Alex Lester on 10/23/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ViewController.h"

@interface MovieDetailsViewController ()


@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.titleLabel.text = self.movie[@"title"];
	self.synopsisLabel.text = self.movie[@"synopsis"];
	// Get thumbnail image
	NSURL *url = [NSURL URLWithString:self.movie[@"posters"][@"detailed"]];
	NSString *flixterAddress = getMoreDetailedImage([url absoluteString], ThumbnailImageSuffix);
	NSURL *flixterURL = [NSURL URLWithString:flixterAddress];
	[self.movieImageView setImageWithURL:flixterURL];
	[self animateImages];
	
	
}

-(void)animateImages {
	//Get detailed image
		NSURL *url = [NSURL URLWithString:self.movie[@"posters"][@"detailed"]];
	NSString *flixterAddressOriginal = getMoreDetailedImage([url absoluteString], OriginalImageSuffix);
	NSURL *flixterURLOriginal = [NSURL URLWithString:flixterAddressOriginal];
	[self.movieImageView setImageWithURL:flixterURLOriginal];
	self.movieImageView.alpha = 0;
	
	[UIView animateWithDuration:2.5
						  delay:0.0
						options: UIViewAnimationCurveEaseOut
					 animations:^{
						self.movieImageView.alpha = 100;
					 }
					 completion:^(BOOL finished){
						 NSLog(@"Done!");
					 }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
