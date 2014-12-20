//
//  ViewController.m
//  NumberTextFieldDemo
//
//  Created by Qin Yuxiang on 12/19/14.
//  Copyright (c) 2014 YuxiangQ. All rights reserved.
//

#import "ViewController.h"
#import "NumberField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NumberField *numberField=[[NumberField alloc] initWithFrame:CGRectMake(100, 100, 120, 44)];
    numberField.placeholder=@"只能输入数字";
    [self.view addSubview:numberField];
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark -
#pragma mark Events Methods
-(void)tap{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
