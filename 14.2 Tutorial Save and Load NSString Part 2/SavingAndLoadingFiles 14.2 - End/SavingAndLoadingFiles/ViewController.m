//
//  ViewController.m
//  SavingAndLoadingFiles
//
//  Created by Paul on 4/11/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *filenameTextField;
@property (weak, nonatomic) IBOutlet UITextView *saveTextView;
@property (weak, nonatomic) IBOutlet UITextView *loadTextView;

@end

@implementation ViewController

- (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)pathInDocumentsDirectory:(NSString *)filename {
    return [[self documentsDirectory] stringByAppendingPathComponent:filename];
}

- (IBAction)saveButtonPressed:(id)sender {
    [self.view endEditing:NO];
    
    // get the filename
    NSString *filename = self.filenameTextField.text;
    
    // create path
    NSString *path = [self pathInDocumentsDirectory:filename];
    
    // save data from textview
    
    NSError *error = nil;
    [self.saveTextView.text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {
        self.loadTextView.text = [error localizedDescription];
    }
    

}
- (IBAction)loadButtonPressed:(id)sender {

    [self.view endEditing:NO];
    
    // filepath to load from
    
    NSString *filepath = [self pathInDocumentsDirectory:self.filenameTextField.text];
    
    // load the string data and set to the textarea
    
    NSError *error = nil;
    
    NSString *loadedTextData = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    self.loadTextView.text = loadedTextData;
    
    if(error) {
        self.loadTextView.text = [error localizedDescription];
    }
    
    
}

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









