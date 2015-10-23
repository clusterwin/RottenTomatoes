//
//  ViewController.m
//  RottenTomatoes
//
//  Created by Alex Lester on 10/20/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "ViewController.h"
#import "MoviesTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	[self fetchMovies];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MoviesTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"movieCell"];
	cell.titleLabel.text = self.movies[indexPath.row][@"title"];
	cell.synopsisLabel.text = self.movies[indexPath.row][@"synopsis"];
	NSURL *url = [NSURL URLWithString:self.movies[indexPath.row][@"posters"][@"detailed"]];
	[cell.posterImageView setImageWithURL:url];
	return cell;
}

- (void) fetchMovies{
	NSString *urlString = @"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json";
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	
	NSURLSession *session =
	[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
								  delegate:nil
							 delegateQueue:[NSOperationQueue mainQueue]];
	
	NSURLSessionDataTask *task = [session dataTaskWithRequest:request
											completionHandler:^(NSData * _Nullable data,
																NSURLResponse * _Nullable response,
																NSError * _Nullable error) {
												if (!error) {
													NSError *jsonError = nil;
													NSDictionary *responseDictionary =
													[NSJSONSerialization JSONObjectWithData:data
																					options:kNilOptions
																					  error:&jsonError];
													NSLog(@"Response: %@", responseDictionary);
													self.movies = responseDictionary[@"movies"];
													[self.tableView reloadData];
												} else {
													NSLog(@"An error occurred: %@", error.description);
												}
											}];
	[task resume];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
