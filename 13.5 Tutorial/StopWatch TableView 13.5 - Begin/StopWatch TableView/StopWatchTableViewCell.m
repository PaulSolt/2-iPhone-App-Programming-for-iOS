//
//  StopWatchTableViewCell.m
//  StopWatch TableView 13.2
//
//  Created by Paul on 3/18/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "StopWatchTableViewCell.h"

@implementation StopWatchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    // iOS 7 - UIScrollView
    for(UIView *subview in self.subviews) {
        if([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)subview;
            [scrollView setDelaysContentTouches:NO];
            break;
        }
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startStopButtonPressed:(id)sender {
    NSLog(@"startStop");
}

- (IBAction)resetButtonPressed:(id)sender {
    NSLog(@"reset");
}
@end
