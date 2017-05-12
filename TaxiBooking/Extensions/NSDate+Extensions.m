
#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)


- (NSString *)getCustomizedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.PMSymbol = @"pm";
    dateFormatter.AMSymbol = @"am";
    dateFormatter.dateFormat = @"E dd MMM hh:mm a";
    
    NSString *dateString = [NSString stringWithFormat:@"%@ pick-up",[dateFormatter stringFromDate:self]];
    return dateString;
}


@end
