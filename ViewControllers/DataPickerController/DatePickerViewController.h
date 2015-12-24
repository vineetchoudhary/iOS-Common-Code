//
//  DatePickerViewController.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerViewController;

@protocol DatePickerDelegate <NSObject>

@optional
-(void)datePickerDidDisappear;
-(void)datepickerController:(DatePickerViewController *)sender selectedDateInString:(NSString *)date andDatePicker:(UIDatePicker *)datePicker;

@end

@interface DatePickerViewController : UIViewController<UINavigationControllerDelegate>

@property(nonatomic,weak) IBOutlet UIDatePicker *datePicker;
@property(nonatomic,strong) NSString *apiKey;
@property(nonatomic,weak) id<DatePickerDelegate> delegate;
@property(nonatomic,strong) UITextField *textFieldDate;

+(DatePickerViewController *)datePickerWithTextField:(UITextField *)textField;
+(DatePickerViewController *)datePickerWithDelegate:(id<DatePickerDelegate>)delegate;
-(void)showDatePicker;

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender;
@end
