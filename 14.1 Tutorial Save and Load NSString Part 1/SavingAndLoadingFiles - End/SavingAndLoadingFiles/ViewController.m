//
//  ViewController.m
//  SavingAndLoadingFiles
//
//  Created by Paul on 4/11/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1. Get the documents folder for the iPhone app
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSLog(@"Document Dir: %@", documentsDirectory);

    // 2. Save a NSString to the folder

    NSString *filename = @"text.txt";
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    NSLog(@"filepath: %@", filepath);
    
    NSString *saveTextData = @"Every app has it's own documents folder";
    
    NSError *error = nil;
    [saveTextData writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error) {
        NSLog(@"Save error: %@", [error localizedDescription]);
    }
    
    // 3. Load a NSString from the folder
    
    error = nil;
    NSString *loadedTextData = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {
        NSLog(@"Error Loading: %@", [error localizedDescription]);
    }
    
    NSLog(@"Loaded Text Data: %@", loadedTextData);
}

@end









