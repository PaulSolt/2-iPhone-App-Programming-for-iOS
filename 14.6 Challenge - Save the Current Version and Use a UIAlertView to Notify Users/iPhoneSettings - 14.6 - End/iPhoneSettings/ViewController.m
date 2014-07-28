//
//  ViewController.m
//  iPhoneSettings
//
//  Created by Paul on 4/15/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *sizeTextField;
@property (weak, nonatomic) IBOutlet UISwitch *videoSwitch;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 1. Test settings (not saved)
//    self.sizeTextField.text = [@(10) stringValue];
//    self.videoSwitch.on = NO;
//    self.volumeSlider.minimumValue = 0;
//    self.volumeSlider.maximumValue = 100;
//    self.volumeSlider.value = 15;
    
    // 2. Register settings with NSUserDefaults
    
    [self registerDefaultSettings];
    
    // 3. Load default settings
    [self loadSettings];
    


}

- (void)registerDefaultSettings {
    
    NSDictionary *settings = @{@"fontSize" : @10,
                               @"videoOn" : @NO,
                               @"volumeSliderMin" : @0,
                               @"volumeSliderMax" : @10,
                               @"volume" : @15
                               };
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:settings];
}

- (void)loadSettings {
    self.sizeTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"fontSize"];
    self.videoSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"videoOn"];
    self.volumeSlider.minimumValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"volumeSliderMin"];
    self.volumeSlider.maximumValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"volumeSliderMax"];
    self.volumeSlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"volume"];
}

- (void)saveSettings {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.sizeTextField.text forKey:@"fontSize"];
    [[NSUserDefaults standardUserDefaults] setBool:self.videoSwitch.on forKey:@"videoOn"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.volumeSlider.minimumValue forKey:@"volumeSliderMin"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.volumeSlider.maximumValue forKey:@"volumeSliderMax"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.volumeSlider.value forKey:@"volume"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)doneButtonPressed:(id)sender {
    // 4. Save Settings
    
    [self saveSettings];
    
}









@end
