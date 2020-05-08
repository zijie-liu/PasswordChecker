//
//  PasswordChecker.m
//
//  Created by Zijie on 5/8/20.
//

#import "PasswordChecker.h"

@implementation PasswordChecker

-(void)checkPasswordStrength:(CDVInvokedUrlCommand *)command{
    CDVPluginResult* pluginResult = nil;
    
    if (command.arguments.count > 0 && [command.arguments.firstObject length] > 0) {
        NSString * passwordInput = command.arguments.firstObject;
        int strengthPoint = 0;
        
        if ([passwordInput length] > kMIN_LENGTH ) {
            strengthPoint = [self evaluatePasswordStrength:passwordInput];
        }
        
        pluginResult =  [self getEvaluationResult:strengthPoint];
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:kMSG_NO_VALUE];
    }
    
    if (self.commandDelegate != NULL) {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

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

-(CDVPluginResult*)getEvaluationResult:(int)strengthPoint {
    switch(strengthPoint) {
        case kLENGHT_TOO_SHORT :
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:kMSG_LENGHT_TOO_SHORT];
        case kWEAK:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kMSG_WEAK];
        case kMEDIUM:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kMSG_MEDIUM];
        case kSTRONG:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kMSG_STRONG];
        case kVERYSTRONG:
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:kMSG_VERYSTRONG];
        default :
            return [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:kMSG_SOMETHING_WENT_WRONG];
    }
}

@end
