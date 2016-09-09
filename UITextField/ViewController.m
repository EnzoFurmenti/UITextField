//
//  ViewController.m
//  UITextField
//
//  Created by EnzoF on 09.09.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"
UIKIT_EXTERN NSString *const UITextFieldTextDidChangeNotification;
@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if( textField.tag != ViewControllerButtonEmail)
    {
        UITextField *currentTextField = [self.arrayTextFields objectAtIndex:textField.tag + 1];
        [currentTextField becomeFirstResponder];
    }
    else
    {
        UITextField *currentTextField = [self.arrayTextFields objectAtIndex:textField.tag];
        [currentTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    UILabel *currentLabel = [self.arrayLabels objectAtIndex:textField.tag];
    currentLabel.text = @"";
    return YES;
}

#pragma mark - ActionUILabel
-(IBAction)actionChangeTextLabel:(UITextField*)sender{
        UILabel *currentLabel = [self.arrayLabels objectAtIndex:sender.tag];
        currentLabel.text = sender.text;
}

@end
