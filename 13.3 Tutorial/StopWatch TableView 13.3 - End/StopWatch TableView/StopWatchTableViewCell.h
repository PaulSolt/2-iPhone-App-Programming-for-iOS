//
//  StopWatchTableViewCell.h
//  StopWatch TableView 13.2
//
//  Created by Paul on 3/18/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopWatchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
- (IBAction)startStopButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;

@end
