//
//  SecuresecureTextField.h
//  SecuresecureTextField
//
//  Created by feng yang on 15/8/6.
//  Copyright (c) 2015年 feng yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecureTextField;
@protocol GSSecureTextFieldDelegate <NSObject>

- (BOOL)secureTextFieldShouldBeginEditing:(SecureTextField *)secureTextField;        // return NO to disallow editing.
- (void)secureTextFieldDidBeginEditing:(SecureTextField *)secureTextField;           // became first responder
- (BOOL)secureTextFieldShouldEndEditing:(SecureTextField *)secureTextField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)secureTextFieldDidEndEditing:(SecureTextField *)secureTextField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)secureTextField:(SecureTextField *)secureTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)secureTextFieldShouldClear:(SecureTextField *)secureTextField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)secureTextFieldShouldReturn:(SecureTextField *)secureTextField;

@end

@interface SecureTextField : UITextField

@end
