//
//  ViewController.h
//  UITextField
//
//  Created by EnzoF on 09.09.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ViewControllerTextFieldFirstName = 0,
    ViewControllerTextFieldLastName  = 1,
    ViewControllerTextFieldLogin     = 2,
    ViewControllerTextFieldPassword  = 3,
    ViewControllerTextFieldAge       = 4,
    ViewControllerTextFieldTel       = 5,
    ViewControllerTextFieldEmail     = 6
}ViewControllerTextFieldType;

@interface ViewController : UIViewController


@property(strong,nonatomic)IBOutletCollection(UITextField) NSArray *arrayTextFields;
@property(strong,nonatomic)IBOutletCollection(UILabel) NSArray *arrayLabels;
-(IBAction)actionChangeTextLabel:(UITextField*)sender;

@end

