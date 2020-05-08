//
//  PasswordChecker.h
//
//  Created by Zijie on 5/8/20.
//

#import <Cordova/CDVPlugin.h>

NS_ASSUME_NONNULL_BEGIN

static int const kMIN_LENGTH = 5;
static NSString * const kMSG_NO_VALUE = @"Please enter password";
static NSString * const kMSG_LENGHT_TOO_SHORT = @"Password length too short";
static NSString * const kMSG_SOMETHING_WENT_WRONG = @"Something Went Wrong";
static NSString * const kMSG_WEAK = @"Weak";
static NSString * const kMSG_MEDIUM = @"Medium";
static NSString * const kMSG_STRONG = @"Strong";
static NSString * const kMSG_VERYSTRONG = @"Very Strong";

enum {
    kLENGHT_TOO_SHORT,
    kWEAK,
    kMEDIUM,
    kSTRONG,
    kVERYSTRONG
};

@interface PasswordChecker : CDVPlugin

/*! @brief To check the password strength and return the evaluation
 @param command CDVInvokedUrlCommand
 @return None
 */
-(void)checkPasswordStrength:(CDVInvokedUrlCommand *)command;

/*! @brief To evaluate the password based on the complexity of it.
 @param passwordInput the password to be evaluated
 @return int
 */
-(int)evaluatePasswordStrength:(NSString*)passwordInput;

/*! @brief Return message based on the strength point.
 @param strengthPoint  the point to evaluate the strength of password
 @return CDVPluginResult*
 */
-(CDVPluginResult*)getEvaluationResult:(int)strengthPoint;

@end

NS_ASSUME_NONNULL_END
