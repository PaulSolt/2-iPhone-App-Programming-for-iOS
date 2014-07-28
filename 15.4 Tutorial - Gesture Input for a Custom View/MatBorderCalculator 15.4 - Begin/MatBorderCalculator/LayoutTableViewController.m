//
//  LayoutTableViewController.m
//  MatBorderCalculator 12.3
//
//  Created by Paul on 3/9/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "LayoutTableViewController.h"
#import "MatBorder.h"

@interface LayoutTableViewController ()

@end

@implementation LayoutTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // select the row
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectedRow inSection:0];
    
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

- (IBAction)doneButtonPressed:(id)sender {
    
    [self.delegate layoutTableViewControllerDidFinish:self];
    
}

- (IBAction)editButtonPressed:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_matBorderLayoutArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    MatBorder *matBorder = _matBorderLayoutArray[indexPath.row];
    cell.textLabel.text = [matBorder description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Row: %d", indexPath.row);
    
    [self.delegate layoutTableViewController:self didSelectIndexPath:indexPath];
    
}

@end
