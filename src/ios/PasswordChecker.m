//
//  PasswordChecker.m
//  Workshop
//
//  Created by Peter on 5/8/20.
//

#import "PasswordChecker.h"

@implementation PasswordChecker

static NSString * const msgNoValue = @"Please enter password";
static NSString * const msgLengthTooShort = @"Password length too short";
static NSString * const msgSomethingWentWrong = @"Something Went Wrong";
static NSString * const msgWeak = @"Weak";
static NSString * const msgMedium = @"Medium";
static NSString * const msgStrong = @"Strong";
static NSString * const msgVeryStrong = @"Very Strong";

/// To check the password strength and return the evaluation
/// @param command CDVInvokedUrlCommand
-(void)checkPasswordStrength:(CDVInvokedUrlCommand *)command{
    CDVPluginResult* pluginResult = nil;
    
    if (command.arguments.count > 0 && [command.arguments.firstObject length] > 0) {
        NSString * passwordInput = command.arguments.firstObject;
        int strengthPoint = 0;
        
        if ([passwordInput length] > 5) {
            strengthPoint = [self evaluatePasswordStrength:passwordInput];
        }
        
        pluginResult =  [self getEvaluationResult:strengthPoint];
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgNoValue];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

/// To evaluate the password based on the complexity of it.
/// @param passwordInput the password to be evaluated
-(int)evaluatePasswordStrength:(NSString*)passwordInput {
    int strengthPoint = 0;
    
    if ([passwordInput rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].length) {
        strengthPoint++;
    }
    
    if ([passwordInput rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]].length) {
        strengthPoint++;
    }
    
    if ([passwordInput rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].length) {
        strengthPoint++;
    }
    
    if ([passwordInput rangeOfCharacterFromSet:[NSCharacterSet punctuationCharacterSet]].length) {
        strengthPoint++;
    }
    
    return strengthPoint;
}

/// Return message based on the strength point.
/// @param strengthPoint  the point to evaluate the strength of password
-(CDVPluginResult*)getEvaluationResult:(int)strengthPoint {
    switch(strengthPoint) {
        case 0:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgLengthTooShort];
        case 1:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgWeak];
        case 2:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgMedium];
        case 3:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgStrong];
        case 4:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgVeryStrong];
        default :
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgSomethingWentWrong];
    }
}

@end
