//
//  ViewController.m
//  StopWatch TableView
//
//  Created by Paul on 3/18/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "StopWatchTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) StopWatchTableViewCell *stopWatchCell;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //    self.tableView.delegate = self;
    
    UINib *stopWatchNib = [UINib nibWithNibName:@"StopWatchTableViewCell" bundle:nil];
    [self.tableView registerNib:stopWatchNib forCellReuseIdentifier:@"StopWatchTableViewCell"];
    self.stopWatchCell = [[stopWatchNib instantiateWithOwner:nil options:nil] firstObject];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    StopWatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StopWatchTableViewCell"];
    
    
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

@end
