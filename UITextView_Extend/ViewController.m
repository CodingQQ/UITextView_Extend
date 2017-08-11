//
//  ViewController.m
//  UITextView_Extend
//
//  Created by LeeQQ on 2017/8/11.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import "ViewController.h"
#import "UITextView_Extend.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextView_Extend *textView = [[UITextView_Extend alloc]initWithFrame:CGRectMake(50, 200, 200, 30)];
    textView.backgroundColor = [UIColor orangeColor];
    textView.autoLine = YES;
    textView.placeholder = @"我是占位文字！！！";
    [self.view addSubview:textView];
    
}





@end
