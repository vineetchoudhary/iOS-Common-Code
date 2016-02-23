//
//  NSDate+TimeAgo.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "NSDate+TimeAgo.h"
#define SECOND  1
#define MINUTE  (SECOND * 60)
#define HOUR    (MINUTE * 60)
#define DAY     (HOUR * 24)
#define WEEK    (DAY * 7)
#define MONTH   (DAY * 31)
#define YEAR    (DAY * 365.24)

@implementation NSDate (TimeAgo)

- (NSString *)formattedAsTimeAgo
{
    NSDate *now = [NSDate date];
    NSTimeInterval secondsSince = -(int)[self timeIntervalSinceDate:now];
    
    if(secondsSince < 0){
        return @"Just now";
    }
    // < 1 minute = "Just now"
    if(secondsSince < MINUTE){
        return @"Just now";
    }
    // < 1 hour = "x minutes ago"
    if(secondsSince < HOUR){
        return [self formatMinutesAgo:secondsSince];
    }
    // Today = "x hours ago"
    if([self isSameDayAs:now]){
        return [self formatAsToday:secondsSince];
    }
    // Yesterday = "Yesterday at 1:28 PM"
    if([self isYesterday:now]){
        return [self formatAsYesterday];
    }
    // < Last 7 days = "Friday at 1:48 AM"
    if([self isLastWeek:secondsSince]){
        return [self formatAsLastWeek];
    }
    // < Last 30 days = "March 30 at 1:14 PM"
    if([self isLastMonth:secondsSince]){
        return [self formatAsLastMonth];
    }
    // < 1 year = "September 15"
    if([self isLastYear:secondsSince]){
        return [self formatAsLastYear];
    }
    // Anything else = "September 9, 2011"
    return [self formatAsOther];
}

- (NSString *)formattedAsTimeAgoWithSeconds
{
    NSDate *now = [NSDate date];
    NSTimeInterval secondsSince = -(int)[self timeIntervalSinceDate:now];
    
    if(secondsSince < 0){
        return @"Just now";
    }
    // < 1 minute = "Just now"
    if(secondsSince < MINUTE){
        return [self formatSecondsAgo:secondsSince];
    }
    // < 1 hour = "x minutes ago"
    if(secondsSince < HOUR){
        return [self formatMinutesAgo:secondsSince];
    }
    // Today = "x hours ago"
    if([self isSameDayAs:now]){
        return [self formatAsToday:secondsSince];
    }
    // Yesterday = "Yesterday at 1:28 PM"
    if([self isYesterday:now]){
        return [self formatAsYesterday];
    }
    // < Last 7 days = "Friday at 1:48 AM"
    if([self isLastWeek:secondsSince]){
        return [self formatAsLastWeek];
    }
    // < Last 30 days = "March 30 at 1:14 PM"
    if([self isLastMonth:secondsSince]){
        return [self formatAsLastMonth];
    }
    // < 1 year = "September 15"
    if([self isLastYear:secondsSince]){
        return [self formatAsLastYear];
    }
    // Anything else = "September 9, 2011"
    return [self formatAsOther];
}

#pragma mark - Formating

// < 1 min = "x seconds ago"
- (NSString *)formatSecondsAgo:(NSTimeInterval)secondsSince{
    if (secondsSince == 1) {
        return @"1 second ago";
    }else{
        return [NSString stringWithFormat:@"%@ seconds ago", [NSNumber numberWithInteger:secondsSince]];
    }
}

// < 1 hour = "x minutes ago"
- (NSString *)formatMinutesAgo:(NSTimeInterval)secondsSince{
    //Convert to minutes
    int minutesSince = (int)secondsSince / MINUTE;
    //Handle Plural
    if(minutesSince == 1){
        return @"1 minute ago";
    }else{
        return [NSString stringWithFormat:@"%d minutes ago", minutesSince];
    }
}

// Today = "x hours ago"
- (NSString *)formatAsToday:(NSTimeInterval)secondsSince{
    //Convert to hours
    int hoursSince = (int)secondsSince / HOUR;
    //Handle Plural
    if(hoursSince == 1){
        return @"1 hour ago";
    }else{
        return [NSString stringWithFormat:@"%d hours ago", hoursSince];
    }
}

// Yesterday = "Yesterday at 1:28 PM"
- (NSString *)formatAsYesterday{
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Format
    [dateFormatter setDateFormat:@"h:mm a"];
    return [NSString stringWithFormat:@"Yesterday at %@", [dateFormatter stringFromDate:self]];
}


// < Last 7 days = "Friday at 1:48 AM"
- (NSString *)formatAsLastWeek{
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Format
    [dateFormatter setDateFormat:@"EEEE 'at' h:mm a"];
    return [dateFormatter stringFromDate:self];
}


// < Last 30 days = "March 30 at 1:14 PM"
- (NSString *)formatAsLastMonth{
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Format
    [dateFormatter setDateFormat:@"MMMM d, yyyy 'at' h:mm a"];
    return [dateFormatter stringFromDate:self];
}


// < 1 year = "September 15"
- (NSString *)formatAsLastYear{
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Format
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    return [dateFormatter stringFromDate:self];
}


// Anything else = "September 9, 2011"
- (NSString *)formatAsOther{
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //Format
    [dateFormatter setDateFormat:@"LLLL d, yyyy"];
    return [dateFormatter stringFromDate:self];
}

- (BOOL)isLastWeek:(NSTimeInterval)secondsSince{
    return secondsSince < WEEK;
}



//Is Last Month. Previous 31 days?
- (BOOL)isLastMonth:(NSTimeInterval)secondsSince{
    return secondsSince < MONTH;
}



//Is Last Year
- (BOOL)isLastYear:(NSTimeInterval)secondsSince{
    return secondsSince < YEAR;
}

- (BOOL)isSameDayAs:(NSDate *)comparisonDate{
    //Check by matching the date strings
    NSDateFormatter *dateComparisonFormatter = [[NSDateFormatter alloc] init];
    [dateComparisonFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //Return true if they are the same
    return [[dateComparisonFormatter stringFromDate:self] isEqualToString:[dateComparisonFormatter stringFromDate:comparisonDate]];
}


// If the current date is yesterday relative to now. Pasing in now to be more accurate (time shift during execution) in the calculations
- (BOOL)isYesterday:(NSDate *)now{
    return [self isSameDayAs:[now dateBySubtractingDays:1]];
}

- (NSDate *) dateBySubtractingDays: (NSInteger) numDays{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + DAY * -numDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

@end
