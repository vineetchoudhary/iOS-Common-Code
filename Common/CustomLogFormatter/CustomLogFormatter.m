//
//  CustomLogFormatter.m
//
//  Created by Vineet Choudhary on 31/08/17.
//  Copyright © 2017 Vineet Choudhary. All rights reserved.
//

#import "CustomLogFormatter.h"

@implementation CustomLogFormatter

-(NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"❌"; break;
        case DDLogFlagWarning  : logLevel = @"❓"; break;
        case DDLogFlagInfo     : logLevel = @"💧"; break;
        case DDLogFlagDebug    : logLevel = @"✅"; break;
        default                : logLevel = @"🔤"; break;
    }
    
    return [NSString stringWithFormat:@"\n\n<====================================================================\n%@ | %@ | TimeStamp - %f\n====================================================================\n%@\n====================================================================>\n", logLevel, [NSDate date], [[NSDate date] timeIntervalSince1970], logMessage->_message];
}

@end
