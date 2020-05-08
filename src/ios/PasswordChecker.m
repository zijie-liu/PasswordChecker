//
//  PasswordChecker.m
//  Workshop
//
//  Created by Peter on 5/8/20.
//

#import "PasswordChecker.h"

@implementation PasswordChecker

static NSString * const msgNoValue = @"No input value";
static NSString * const msgLengthTooShort = @"Password length too short";
static NSString * const msgSomethingWentWrong = @"Something Went Wrong";
static NSString * const msgWeak = @"Weak";
static NSString * const msgMedium = @"Medium";
static NSString * const msgStrong = @"Strong";
static NSString * const msgVeryStrong = @"Very Strong";

-(void)checkPasswordStrength:(CDVInvokedUrlCommand *)command{
    
    CDVPluginResult* pluginResult = nil;
    
    
    if (command.arguments.count > 0 && [command.arguments.firstObject length] > 0) {
        NSString * passwordInput = command.arguments.firstObject;
        int strengthPoint = 0;
        
        if ([passwordInput length] > 6) {
            strengthPoint++;
            
            if ([passwordInput rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]].length) {
                strengthPoint++;
            }
            
            if ([passwordInput rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].length) {
                strengthPoint++;
            }
            
            if ([passwordInput rangeOfCharacterFromSet:[NSCharacterSet punctuationCharacterSet]].length) {
                strengthPoint++;
            }
        }

        switch(strengthPoint){
            case 0:
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgLengthTooShort];
                break;
            case 1:
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgWeak];
                break;
            case 2:
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgMedium];
                break;
            case 3:
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgStrong];
                break;
            case 4:
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgVeryStrong];
                break;
            default :
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgSomethingWentWrong];
                break;
        }
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgNoValue];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

@end
