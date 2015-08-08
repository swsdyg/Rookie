//
//  PlaceHolderTextView.h
//  Secretary
//
//  Created by feng yang on 15/4/20.
//  Copyright (c) 2015年 feng yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceHolderTextView;

@protocol PlaceHoldTextViewDelegate<NSObject, UIScrollViewDelegate>

@optional

- (BOOL)placeHolderTextViewShouldBeginEditing:(PlaceHolderTextView *)textView;
- (BOOL)placeHolderTextViewShouldEndEditing:(PlaceHolderTextView *)textView;

- (void)placeHolderTextViewDidBeginEditing:(PlaceHolderTextView *)textView;
- (void)placeHolderTextViewDidEndEditing:(PlaceHolderTextView *)textView;

- (BOOL)placeHolderTextView:(PlaceHolderTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)placeHolderTextViewDidChange:(PlaceHolderTextView *)textView;

- (void)placeHolderTextViewDidChangeSelection:(PlaceHolderTextView *)textView;

- (BOOL)placeHolderTextView:(PlaceHolderTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
- (BOOL)placeHolderTextView:(PlaceHolderTextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);

@end


@interface PlaceHolderTextView : UITextView<UITextViewDelegate>

@property (nonatomic, weak) id<PlaceHoldTextViewDelegate> holderDelegate;

@end
