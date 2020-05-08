//
//  PasswordChecker.h
//  Workshop
//
//  Created by Peter on 5/8/20.
//

#import <Cordova/CDVPlugin.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasswordChecker : CDVPlugin

-(void)checkPasswordStrength:(CDVInvokedUrlCommand *)command;

@end

NS_ASSUME_NONNULL_END
