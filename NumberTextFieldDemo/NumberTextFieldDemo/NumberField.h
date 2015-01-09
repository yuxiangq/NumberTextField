//
//  NumberField.h
//  NumberTextFieldDemo
//
//  Created by Qin Yuxiang on 12/19/14.
//  Copyright (c) 2014 YuxiangQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct Numeric{
   NSInteger length;
   NSInteger decimalDigits;
} Numeric;

CG_INLINE Numeric
CGNumeric(NSInteger length, NSInteger decimalDigits)
{
    Numeric num; num.length = length; num.decimalDigits = decimalDigits; return num;
}

@interface NumberField : UITextField

@property (assign,nonatomic) Numeric numeric;

-(NSString*)trimText;

@end





