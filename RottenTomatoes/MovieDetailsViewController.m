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
	NSURL *url = [NSURL URLWithString:self.movie[@"posters"][@"detailed"]];
	NSString *flixterAddress = getMoreDetailedImage([url absoluteString], OriginalImageSuffix);
	NSURL *flixterURL = [NSURL URLWithString:flixterAddress];
	[self.movieImageView setImageWithURL:flixterURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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