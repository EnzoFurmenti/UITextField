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
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.x, 200, 30)];
    [self.view addSubview:textField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationChangeTextInTextField:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag != ViewControllerTextFieldEmail)
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if((textField.tag == ViewControllerTextFieldTel))
    {
        NSString *newString = [self getValidNumberString:textField.text withRange:range withString:string];
        if(newString)
        {
            NSString *resultString =  [self createTeleStringFromString:newString];
            if(resultString)
            {
                textField.text = resultString;
            }
        }
        
        return NO;
    }
    
    if(textField.tag == ViewControllerTextFieldEmail)
    {
        NSString *resultString = [self separateEmailString:textField.text withRange:range withString:string];
        if(resultString)
        {
            textField.text = resultString;
        }
        return NO;
    }
    return YES;
}

#pragma mark - ActionUILabel
-(IBAction)actionChangeTextLabel:(UITextField*)sender{
        UILabel *currentLabel = [self.arrayLabels objectAtIndex:sender.tag];
        currentLabel.text = sender.text;
}


#pragma mark - UITextFieldNotification

-(void)notificationChangeTextInTextField:(NSNotification*)notification{
    for (UITextField *currentTextField in self.arrayTextFields)
    {
        if([currentTextField isFirstResponder])
        {
            NSLog(@"TextField tag %d",currentTextField.tag);
        }
    }
    
}


#pragma mark - metods for TeleString
-(NSString*)getValidNumberString:(NSString*)currentString withRange:(NSRange)range withString:(NSString*)string{
    NSCharacterSet *validSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *component = [string componentsSeparatedByCharactersInSet:validSet];
    NSString *newString;
    if(!([component count] > 1))
    {
        newString = [currentString stringByReplacingCharactersInRange:range withString:string];
        NSArray *validComponent = [newString componentsSeparatedByCharactersInSet:validSet];
        newString = [validComponent componentsJoinedByString:@""];
    }
    return newString;
}

-(NSString*)createTeleStringFromString:(NSString*)string{
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countrycCodeMaxLength = 3;
    NSInteger queueSymbolsBeforeDash = 3;
    NSMutableString *resultString = [NSMutableString string];
    if([string length] >localNumberMaxLength + areaCodeMaxLength + countrycCodeMaxLength)
    {
        resultString = nil;
    }
    else
    {
        NSInteger localNumberLength = MIN([string length],localNumberMaxLength);
        if(localNumberLength > 0)
        {
            NSString *number = [string substringFromIndex:(int)[string length] - localNumberLength];
            [resultString appendString:number];
            if([resultString length] > queueSymbolsBeforeDash)
            {
                [resultString insertString:@"-" atIndex:queueSymbolsBeforeDash];
            }
        }
        if([string length] > localNumberMaxLength)
        {
            NSInteger areaCodeLength = MIN((int)[string length] - localNumberMaxLength,areaCodeMaxLength);
            NSRange areaRange = NSMakeRange((int)[string length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
            NSString *area = [string substringWithRange:areaRange];
            area = [NSString stringWithFormat:@"(%@)",area];
            [resultString insertString:area atIndex:0];
        }
        
        if([string length] > localNumberMaxLength + areaCodeMaxLength)
        {
            NSInteger countryCodeLength = MIN((int)[string length] - localNumberMaxLength - areaCodeMaxLength,countrycCodeMaxLength);
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
            NSString *countryCode = [string substringWithRange:countryCodeRange];
            countryCode = [NSString stringWithFormat:@"+%@",countryCode];
            [resultString insertString:countryCode atIndex:0];
        }
    }
    return resultString;
}

#pragma mark - metods for TextFieldEmail
-(NSString* _Nullable)separateEmailString:(NSString*)emailStr withRange:(NSRange)range withString:(NSString*)string{
    
    NSString *validCharactersString = @"@!#$%&'*+-/=?^_`{|}~.";
    NSInteger maxLengthEmail = 30;
    NSCharacterSet *numberCharSet = [NSCharacterSet decimalDigitCharacterSet];
    NSMutableCharacterSet *validMutableCharSet = [NSMutableCharacterSet letterCharacterSet];
    [validMutableCharSet formUnionWithCharacterSet:numberCharSet];
    [validMutableCharSet addCharactersInString:validCharactersString];
    [validMutableCharSet invert];

    NSArray *component = [string componentsSeparatedByCharactersInSet:validMutableCharSet];
    NSString *newString = nil;
    if(!([component count] > 1))
    {
        newString = [emailStr stringByReplacingCharactersInRange:range withString:string];
        NSArray *componentDog = [newString componentsSeparatedByString:@"@"];
        if(([componentDog count] <= 2)&
           ![newString containsString:@".."]&
           ([newString length] < maxLengthEmail))
        {
            NSArray *validComponent = [newString componentsSeparatedByCharactersInSet:validMutableCharSet];
            newString = [validComponent componentsJoinedByString:@""];
        }
        else
        {
            newString = nil;
        }
    }
    return newString;
}


@end
