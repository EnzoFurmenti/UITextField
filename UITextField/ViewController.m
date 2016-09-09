//
//  ViewController.m
//  UITextField
//
//  Created by EnzoF on 09.09.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
