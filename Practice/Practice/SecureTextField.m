//
//  SecureTextField.m
//  SecureTextField
//
//  Created by feng yang on 15/8/6.
//  Copyright (c) 2015年 feng yang. All rights reserved.
//

#import "SecureTextField.h"

@interface SecureTextField()<UITextFieldDelegate>

@property (nonatomic, assign)  id<GSSecureTextFieldDelegate> secureDelegate;

@end

@implementation SecureTextField

-(void)awakeFromNib
{
    self.delegate = self;
    self.secureTextEntry = YES;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.secureTextEntry = YES;
    }
    return self;
}

-(void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    if (delegate != self) {
        self.secureDelegate = (id<GSSecureTextFieldDelegate>)delegate;
    }
    [super setDelegate:self];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.secureTextEntry) {
        if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextField:shouldChangeCharactersInRange:replacementString:)]) {
          BOOL change =  [self.secureDelegate secureTextField:(SecureTextField *)textField shouldChangeCharactersInRange:range replacementString:string];
            if (!change) {
                return NO;
            }
        }
        ///直接调用这个方法,在打断点的情况下会连续输入两个相同的字符
//        [self replaceRange:self.selectedTextRange withText:string];
        NSString *str = nil;
        if ([string isEqualToString:@""]) {//点击的是删除键
            ///如果直接返回yes会一下把所有的内容都删完
            str = [[self.text substringToIndex:range.location] stringByAppendingString:[self.text substringFromIndex:(range.location + range.length)]];
        } else {
            if (range.length == 0) {//表示没有内容被选中
                if (range.location == self.text.length) {
                    //光标在最后面
                    str = [self.text stringByAppendingString:string];
                } else {
                    //光标不在最后面
                    str = [[[self.text substringToIndex:range.location] stringByAppendingString:string] stringByAppendingString:[self.text substringFromIndex:(range.location + range.length)]];
                }
            } else {
                //表示有选中的内容，这时需要把选中的内容截掉，拼接上刚输入的内容，再拼接上原来的内容后面的字符串
                str = [self.text stringByReplacingCharactersInRange:range withString:string];
            }
        }
        self.text = str;
        return NO;
    }else{
        
        if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextField:shouldChangeCharactersInRange:replacementString:)]) {
            return [self.secureDelegate secureTextField:(SecureTextField *)textField shouldChangeCharactersInRange:range replacementString:string];
        }
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextFieldShouldBeginEditing:)]) {
        return  [self.secureDelegate secureTextFieldShouldBeginEditing:(SecureTextField *)textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextFieldDidBeginEditing:)]) {
        [self.secureDelegate secureTextFieldShouldBeginEditing:(SecureTextField *)textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextFieldShouldBeginEditing:)]) {
        return [self.secureDelegate secureTextFieldShouldEndEditing:(SecureTextField *)textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextFieldDidEndEditing:)]) {
        [self.secureDelegate secureTextFieldDidEndEditing:(SecureTextField *)textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextFieldShouldClear:)]) {
        return [self.secureDelegate secureTextFieldShouldClear:(SecureTextField *)textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.secureDelegate && [self.secureDelegate respondsToSelector:@selector(secureTextFieldShouldReturn:)]) {
       return  [self.secureDelegate secureTextFieldShouldReturn:(SecureTextField *)textField];
    }
    return YES;
}


#pragma mark - 重写粘贴的方法,因为如果不重写的话,第一次粘贴textfield的内容会变成空
-(void)paste:(id)sender
{
    UIPasteboard *pastboard = [UIPasteboard  generalPasteboard];
    NSString *pastboardStr = pastboard.string;
    UITextRange *range = self.selectedTextRange;
    [self replaceRange:range withText:pastboardStr];
}

@end
