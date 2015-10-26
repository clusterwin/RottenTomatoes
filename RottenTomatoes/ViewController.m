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
#import "MovieDetailsViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property(nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	[self fetchMovies];
	// Initialize the refresh control.
	self.refreshControl = [[UIRefreshControl alloc] init];
	self.refreshControl.backgroundColor = [UIColor purpleColor];
	self.refreshControl.tintColor = [UIColor whiteColor];
	[self.tableView addSubview:self.refreshControl];
	[self.refreshControl addTarget:self
							action:@selector(refreshTable)
				  forControlEvents:UIControlEventValueChanged];

}

- (void)refreshTable {
	[self fetchMovies];
	[self.refreshControl endRefreshing];
	[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MoviesTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"movieCell"];
	cell.titleLabel.text = self.movies[indexPath.row][@"title"];
	cell.synopsisLabel.text = self.movies[indexPath.row][@"synopsis"];
	NSURL *url = [NSURL URLWithString:self.movies[indexPath.row][@"posters"][@"detailed"]];
	NSString *flixterAddress = getMoreDetailedImage([url absoluteString], ProfileImageSuffix);
	NSURL *flixterURL = [NSURL URLWithString:flixterAddress];
	[cell.posterImageView setImageWithURL:flixterURL];
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
													//NSLog(@"Response: %@", responseDictionary);
													self.movies = responseDictionary[@"movies"];
													[self.tableView reloadData];
												} else {
													NSLog(@"An error occurred: %@", error.description);
												}
											}];
	[task resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	MoviesTableViewCell *cell = sender;
	NSIndexPath *indexPath = [self.tableView indexPathForCell:(cell)];
	
	NSDictionary *movie = self.movies[indexPath.row];
	MovieDetailsViewController *movieDetailsViewController = segue.destinationViewController;
	movieDetailsViewController.movie = movie;
	
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
	[self.tableView deselectRowAtIndexPath:(indexPath) animated:YES];

}

NSString *getMoreDetailedImage(NSString* url , NSString* detailRequired){
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(.*)(movie.*)_(.*)"
	options:NSRegularExpressionCaseInsensitive error:&error];
	
	NSTextCheckingResult *match = [regex firstMatchInString:url
													options:0
													  range:NSMakeRange(0, [url length])];
	NSString *moviesSubString;
	if (match) {
		NSRange secondHalfRange = [match rangeAtIndex:2];
		moviesSubString = [url substringWithRange:secondHalfRange];
		moviesSubString = [FlixerNewAddress stringByAppendingString:moviesSubString];
		moviesSubString = [moviesSubString stringByAppendingString:detailRequired];
		moviesSubString = [moviesSubString stringByAppendingString:@".jpg"];
	}
	return moviesSubString;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	if (self.movies){
		return 1;
	} else {
		// Display a message when the table is empty
		UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		
		messageLabel.text = @"No data is currently available. Please pull down to refresh.";
		messageLabel.textColor = [UIColor blackColor];
		messageLabel.numberOfLines = 0;
		messageLabel.textAlignment = NSTextAlignmentCenter;
		messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
		[messageLabel sizeToFit];
		
		self.tableView.backgroundView = messageLabel;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
	return 0;
}



@end
