//
//  DatePickerViewController.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//


#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeDatePickerWithAnimation)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(DatePickerViewController *)datePickerWithTextField:(UITextField *)textField{
    DatePickerViewController *datePicker = nil;
    if (datePicker == nil) {
        datePicker = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
        [datePicker.view setTag:FirstResponderDataPicker];
        if (datePicker.textFieldDate == nil) {
            [datePicker setTextFieldDate:textField];
        }
    }
    [datePicker.datePicker setDate:([DataValidation isEmptyString:textField.text])?[NSDate date]:[CommonFunction dateFromString:textField.text]];
    return datePicker;
}

+(DatePickerViewController *)datePickerWithDelegate:(id<DatePickerDelegate>)delegate
{
    DatePickerViewController *datePicker = nil;
    if (datePicker == nil) {
        datePicker = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
        [datePicker.view setTag:FirstResponderDataPicker];
        [datePicker setDelegate:delegate];
    }
    return datePicker;
}

-(void)showDatePicker{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self.view];
    [self.view setFrame:keyWindow.bounds];
    [self.view setAlpha:0];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setAlpha:1];
    }];
}

-(void)removeDatePickerWithAnimation{
    [UIView animateWithDuration:0.0 animations:^{
    } completion:^(BOOL finished) {
        [self datePickerValueChanged:_datePicker];
        [self.view removeFromSuperview];
        [self.delegate datePickerDidDisappear];
    }];
}


#pragma mark -date picker actions

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [_textFieldDate setText:[dateFormatter stringFromDate:sender.date]];
    [self.delegate datepickerController:self selectedDateInString:[dateFormatter stringFromDate:sender.date] andDatePicker:sender];
}


@end
