//
//  ViewController.h
//  UITextView_Extend
//
//  Created by LeeQQ on 2017/8/11.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//  https://github.com/CodingQQ/UITextView_Extend.git

#import <UIKit/UIKit.h>

@interface UITextView_Extend : UITextView
#pragma mark -占位文字-
/**
 *  占位文字
 */
@property(nonatomic, copy) NSString *placeholder;
/**
 *  占位文字 颜色
 */
@property (nonatomic,retain)UIColor *placeholderColor;
/**
 *  输入的文字 颜色，等同于系统的 textColor
 */
@property (nonatomic,retain)UIColor *contentTextColor;

#pragma mark -自动换行-
/**
 *  是否自动换行，默认NO（不会自动换行）
 */
@property (nonatomic,assign)BOOL autoLine;
/**
 *  允许自动换行的最大高度，默认50
 */
@property (nonatomic,assign)CGFloat maxTextViewH;
/**
 *  自动换行时，向上还是向下，默认向上
 */
@property (nonatomic,assign)BOOL isDown;




@end
