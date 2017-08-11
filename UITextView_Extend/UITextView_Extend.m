//
//  ViewController.h
//  UITextView_Extend
//
//  Created by LeeQQ on 2017/8/11.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import "UITextView_Extend.h"


#define DefaultFont  [UIFont systemFontOfSize:14]
#define DefaultPlaceholderColor  [UIColor lightGrayColor]
#define DefaultContentTextColor  [UIColor blackColor]
#define DefaultMaxTextViewH  100 // 默认的最大高度

@interface UITextView_Extend ()
/** 自动换行之前的content高度 */
@property (nonatomic,assign)CGFloat contentH;
/** 创建TextView的时候，指定的高度 */
@property (nonatomic,assign)CGFloat originalH;
@end
@implementation UITextView_Extend


/**
 *  默认设置
 */
- (void)defaultTextSet{
    [self addObserver];
    
    self.placeholderColor = DefaultPlaceholderColor;
    self.contentTextColor = DefaultContentTextColor;
    self.maxTextViewH = DefaultMaxTextViewH;
    self.font = DefaultFont;
    self.keyboardType = UIKeyboardTypeDefault;
    // 文字 与 边框 的内间距
    self.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
}
// 初始化
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self defaultTextSet];
        
    }
    return self;
}

#pragma mark 注册通知
- (void)addObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    //...DidEndEditingNotification 调用的前提是有...DidChangeNotification通知（原因未知）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

#pragma mark 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 通知方法
/**
 *  开始编辑
 */
- (void)textDidBeginEditing:(NSNotification *)notification {
    if ([self.text isEqualToString:_placeholder]) {
        self.text = @"";
        [self setTextColor:_contentTextColor];
    }
    // 允许换行，设置 文字内容高度初始值
    if (self.autoLine) {
        [self startContentH];
    }
}

/**
 *  文字改变
 */
-(void) textDidChange:(UITextView *)textView
{
    if(self.text.length == 0){
        self.text = _placeholder;
        self.textColor = _placeholderColor;
        [self  resignFirstResponder];
    }
    // 允许换行，计算是否该换行了
    if (self.autoLine) {
        [self autoLineHandle];
    }
}
/**
 *  结束编辑
 */
- (void)textDidEndEditing:(NSNotification *)notification {
    if (self.text.length == 0) {
        self.text = _placeholder;
        //如果文本框内是原本的提示文字，则显示灰色字体
        [self setTextColor:_placeholderColor];
        
    }
}

#pragma mark 换行处理方法
/**
 *  开始编辑时，设置默认值
 */
- (void)startContentH{
    
    CGSize size = [self.text sizeWithAttributes:@{
                                    NSFontAttributeName: DefaultFont
                                    }];
    self.contentH = size.height;
    self.originalH = self.frame.size.height;
}
/**
 *  自动换行处理
 */
- (void)autoLineHandle{
    // 输入内容size
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DefaultFont} context:nil].size.height;
    
    if (self.contentH != textH & textH>=self.originalH & textH <= self.maxTextViewH) {
        
        CGRect frame = self.frame;
        frame.size.height = textH;
        //向上走时（isDown=NO） chazhi 为正，即高度变大，y上升即变小；为负，即高度变小，y下降即变大
        CGFloat chazhi = textH - self.contentH;
        frame.origin.y =self.isDown ? frame.origin.y : frame.origin.y - chazhi;
        self.frame = frame;
        
        self.contentH = textH;
        
    }
}


#pragma mark 重写set方法
/**
 *  占位文字
 */
- (void)setPlaceholder:(NSString *)aPlaceholder {
    _placeholder = aPlaceholder;
    [self textDidEndEditing:nil];
    [self  resignFirstResponder];
}
/**
 *  占位文字 颜色
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.textColor = _placeholderColor;
    
}
/**
 *  输入的文字 颜色，等同于系统的 textColor
 */
-(void)setContentTextColor:(UIColor *)contentTextColor{
    _contentTextColor = contentTextColor;
    [self setTextColor:_contentTextColor];
}

/**
 *  重写 系统textColor set方法，等同于 _contentTextColor
 */
- (void)setTextColor:(UIColor *)textColor{
    _contentTextColor = textColor;
    if ([super.text isEqualToString:_placeholder]) {
        [super setTextColor:_placeholderColor];
    }else{
        [super setTextColor:_contentTextColor];
    }
    
}






@end
