//
//  UnitSliderView.h
//  MatBorderCalculator 15.1
//
//  Created by Paul on 4/21/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitSliderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *wholeNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *fractionLabel;
@property (strong, nonatomic) IBOutlet UIView *view;

@end
