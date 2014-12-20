//
//  NumberField.m
//  NumberTextFieldDemo
//
//  Created by Qin Yuxiang on 12/19/14.
//  Copyright (c) 2014 YuxiangQ. All rights reserved.
//

#import "NumberField.h"

static NSString *const kDecimalPoint=@".";
static const int kNumericDefaultLength=8;
static const int kNumericDefaultDigits=2;

@interface NumberField ()<UITextFieldDelegate>{
    BOOL _hasDecimalPoint;
}

@end

@implementation NumberField

#pragma mark -
#pragma mark Init Methods
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _hasDecimalPoint=NO;
        self.borderStyle=UITextBorderStyleRoundedRect;
        self.keyboardType=UIKeyboardTypeDecimalPad;
        self.delegate=self;
        
    }
    return self;
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    //判断数字总长度,默认长度为8.
    int length=self.numeric.length==0?kNumericDefaultLength:self.numeric.length;
    //判断是否输入的是小数点
    if ([string isEqualToString:kDecimalPoint]) {
        //判断是否已输入过小数点
        if ([textField.text rangeOfString:kDecimalPoint].length==0) {
            //未输入过小数点
            if (length<(textField.text.length+string.length)) {
                return NO;
            }
            return YES;
        }
        else{
            //已输入过小数点
            return NO;
        }
    }
    else{
        //输入的不是小数点
        //判断是否已输入过小数点
        if ([textField.text rangeOfString:kDecimalPoint].length==0) {
            //未输入过小数点
            return length>=(textField.text.length+string.length);
        }
        else{
            //已输入过小数点,则要分开判断整数部分和小数部分。
            NSMutableString *tempString=[NSMutableString stringWithString:textField.text];
            [tempString insertString:string atIndex:range.location];
            NSRange digitsRange=[tempString rangeOfString:kDecimalPoint];
            
            //获取整数部分
            NSString *integerString=[tempString substringToIndex:digitsRange.location];
            //获取小数部分
            NSString *decimalString=[tempString substringFromIndex:digitsRange.location+1];
            
            if (integerString.length>(length-(self.numeric.digits==0?kNumericDefaultDigits:self.numeric.digits))) {
                return NO;
            }
            
            if (decimalString.length>(self.numeric.digits==0?kNumericDefaultDigits:self.numeric.digits)) {
                return NO;
            }
        }
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSMutableString *tempString=[NSMutableString stringWithString:textField.text];
    if ([[tempString substringToIndex:1] isEqualToString:kDecimalPoint]) {
        [tempString insertString:@"0" atIndex:0];
        textField.text=tempString;
    }
}

@end
