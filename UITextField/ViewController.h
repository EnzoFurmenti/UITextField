//
//  ViewController.h
//  UITextField
//
//  Created by EnzoF on 09.09.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ViewControllerButtonFirstName = 0,
    ViewControllerButtonLastName  = 1,
    ViewControllerButtonLogin     = 2,
    ViewControllerButtonPassword  = 3,
    ViewControllerButtonAge       = 4,
    ViewControllerButtonTel       = 5,
    ViewControllerButtonEmail     = 6
}ViewControllerButtonType;

@interface ViewController : UIViewController


@property(strong,nonatomic)IBOutletCollection(UITextField) NSArray *arrayTextFields;

@end

