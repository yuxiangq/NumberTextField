//
//  NumberField.h
//  NumberTextFieldDemo
//
//  Created by Qin Yuxiang on 12/19/14.
//  Copyright (c) 2014 YuxiangQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct Numeric{
   int length;
   int digits;
} Numeric;

CG_INLINE Numeric
CGNumeric(NSInteger length, NSInteger digits)
{
    Numeric num; num.length = length; num.digits = digits; return num;
}



@interface NumberField : UITextField

@property (assign,nonatomic) Numeric numeric;

@end





