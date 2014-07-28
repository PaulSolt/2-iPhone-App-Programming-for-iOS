//
//  ViewController.m
//  StopWatch TableView
//
//  Created by Paul on 3/18/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "StopWatchTableViewCell.h"
#import "StopWatch.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *_stopWatchArray;
}



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) StopWatchTableViewCell *stopWatchCell;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _stopWatchArray = [@[] mutableCopy];
    
    StopWatch *stopWatch = [[StopWatch alloc] init];
    
    [_stopWatchArray addObject:stopWatch];
    //    self.tableView.delegate = self;
    
    UINib *stopWatchNib = [UINib nibWithNibName:@"StopWatchTableViewCell" bundle:nil];
    [self.tableView registerNib:stopWatchNib forCellReuseIdentifier:@"StopWatchTableViewCell"];
    self.stopWatchCell = [[stopWatchNib instantiateWithOwner:nil options:nil] firstObject];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_stopWatchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    StopWatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StopWatchTableViewCell"];
    
    
    StopWatch *stopWatch = _stopWatchArray[indexPath.row];
    stopWatch.delegate = nil;
    
    cell.stopWatch = stopWatch;
    stopWatch.delegate = cell;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Configure cell for the current row index
    
    // Force layout
    [self.stopWatchCell layoutIfNeeded];
    
    CGSize size = [self.stopWatchCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    CGFloat separatorHeight = 1;
    
    return size.height + separatorHeight;
}
- (IBAction)addButtonPressed:(id)sender {
    
    StopWatch *stopWatch = [[StopWatch alloc] init];
    [_stopWatchArray addObject:stopWatch];
    
    [self.tableView reloadData];
    
}

@end
