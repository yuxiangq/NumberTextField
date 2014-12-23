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
        self.adjustsFontSizeToFitWidth=YES;
        self.minimumFontSize=10;
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
            
            if (integerString.length>(length-(self.numeric.decimalDigits==0?kNumericDefaultDigits:self.numeric.decimalDigits))) {
                return NO;
            }
            
            if (decimalString.length>(self.numeric.decimalDigits==0?kNumericDefaultDigits:self.numeric.decimalDigits)) {
                return NO;
            }
        }
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSMutableString *tempString=[NSMutableString stringWithString:textField.text];
    if ([tempString isEqualToString:@""]) {
        return;
    }
    
    //如果首位为小数点则补0。
    if ([[tempString substringToIndex:1] isEqualToString:kDecimalPoint]) {
        [tempString insertString:@"0" atIndex:0];
        textField.text=tempString;
        return;
    }
    
    //如果末位为小数点则去掉小数点
    if ([[tempString substringFromIndex:tempString.length-1] isEqualToString:kDecimalPoint]) {
        tempString=[NSMutableString stringWithString:[tempString substringToIndex:tempString.length-1]];
    }
    
    
    //去除数字前多余的0
    if ([tempString rangeOfString:kDecimalPoint].length==0) {
        //没有小数点
        while ([[tempString substringToIndex:1] isEqualToString:@"0"]) {
            tempString=[NSMutableString stringWithString:[tempString substringFromIndex:1]];
            if (tempString.length==1) {
                break;
            }
        }
    }
    else{
        //有小数点
        //将数字分割为整数部分和小数部分
        NSRange digitsRange=[tempString rangeOfString:kDecimalPoint];
        //获取整数部分
        NSString *integerString=[tempString substringToIndex:digitsRange.location];
        //获取小数部分
        NSString *decimalString=[tempString substringFromIndex:digitsRange.location+1];
        
        //去掉整数部分的0
        while ([[integerString substringToIndex:1] isEqualToString:@"0"]) {
            integerString=[NSMutableString stringWithString:[integerString substringFromIndex:1]];
            if (integerString.length==1) {
                break;
            }
        }

        tempString=[NSMutableString stringWithFormat:@"%@.%@",integerString,decimalString];
//        //去掉小数部分末位的0
//        
//        while ([[decimalString substringFromIndex:decimalString.length-1] isEqualToString:@"0"]) {
//            decimalString=[NSMutableString stringWithString:[decimalString substringFromIndex:decimalString.length-2]];
//        }
    }

    textField.text=tempString;
    
}

@end
