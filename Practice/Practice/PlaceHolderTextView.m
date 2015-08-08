//
//  PlaceHolderTextView.m
//  Secretary
//
//  Created by feng yang on 15/4/20.
//  Copyright (c) 2015年 feng yang. All rights reserved.
//

#import "PlaceHolderTextView.h"

@interface PlaceHolderTextView ()
{}
@property (nonatomic, copy) NSString *holder;
@end

@implementation PlaceHolderTextView

- (void)awakeFromNib
{
    if (self.text) {
        self.holder = self.text;
    }
}

#pragma mark - 重写get方法
-(NSString *)text
{
    if ([[super text] isEqualToString:self.holder]) {
        return @"";
    }
    return [super text];
}

-(void)setDelegate:(id<UITextViewDelegate>)delegate
{
    if (delegate) {
        if (delegate != self) {
            self.holderDelegate = (id<PlaceHoldTextViewDelegate>)delegate;
        }
        [super setDelegate:self];
    }
}

-(void)setHolder:(NSString *)holder
{
    _holder = holder;
    self.textColor = [UIColor grayColor];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextViewShouldBeginEditing:)]) {
        return [self.holderDelegate placeHolderTextViewShouldBeginEditing:(PlaceHolderTextView *)textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextViewShouldEndEditing:)]) {
        return [self.holderDelegate placeHolderTextViewShouldEndEditing:(PlaceHolderTextView *)textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.text isEqualToString:@""]) {
        [self setSelectedRange:NSMakeRange(0, 0)];
    }
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextViewDidBeginEditing:)]) {
        [self.holderDelegate placeHolderTextViewDidBeginEditing:(PlaceHolderTextView *)textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextViewDidEndEditing:)]) {
        [self.holderDelegate placeHolderTextViewDidEndEditing:(PlaceHolderTextView *)textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([textView.text isEqualToString:@""] && ![text isEqualToString:@""]) {
        textView.text = @"";
        self.textColor = [UIColor blackColor];
    }
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextView:shouldChangeTextInRange:replacementText:  )]) {
        return [self.holderDelegate placeHolderTextView:(PlaceHolderTextView *)textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    self.textColor = [UIColor blackColor];
    if ([self.text isEqualToString:@""]) {
        [super setText:self.holder];
        self.textColor = [UIColor grayColor];
    }else if ([self.text containsString:self.holder]) {
        self.text = [self.text substringToIndex:self.text.length - self.holder.length];
    }
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextViewDidChange:)]) {
        [self.holderDelegate placeHolderTextViewDidChange:(PlaceHolderTextView *)textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.selectedRange.location != 0 && [self.text isEqualToString:@""]) {
        self.selectedRange = NSMakeRange(0, 0);
    }
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextViewDidChangeSelection:)]) {
        [self.holderDelegate placeHolderTextViewDidChangeSelection:(PlaceHolderTextView *)textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextView:shouldInteractWithURL:inRange:    )]) {
        return [self.holderDelegate placeHolderTextView:(PlaceHolderTextView *)textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    if (self.holderDelegate && [self.holderDelegate respondsToSelector:@selector(placeHolderTextView:shouldInteractWithTextAttachment:inRange:)]) {
        return [self.holderDelegate placeHolderTextView:(PlaceHolderTextView *)textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

@end
