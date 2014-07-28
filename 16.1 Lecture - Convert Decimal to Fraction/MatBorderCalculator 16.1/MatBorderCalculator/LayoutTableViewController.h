//
//  LayoutTableViewController.h
//  MatBorderCalculator 12.3
//
//  Created by Paul on 3/9/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

// Forward Declaration
@class LayoutTableViewController;

@protocol LayoutTableViewControllerDelegate <NSObject>

// required method
- (void)layoutTableViewControllerDidFinish:(LayoutTableViewController *)layoutTableViewController;
- (void)layoutTableViewController:(LayoutTableViewController *)layoutTableViewController didSelectIndexPath:(NSIndexPath *)indexPath;
@optional

// optional methods
@end



@interface LayoutTableViewController : UITableViewController

@property (weak, nonatomic) NSMutableArray *matBorderLayoutArray;
@property (weak, nonatomic) id<LayoutTableViewControllerDelegate> delegate;
@property (assign, nonatomic) NSInteger selectedRow;

@end
