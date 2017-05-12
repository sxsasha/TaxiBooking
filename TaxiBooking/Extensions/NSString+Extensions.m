
#import "NSDate+Extensions.h"

@implementation NSString (Extensions)


#pragma mark - Validation

- (BOOL)isMail {
    NSArray<NSString*> *emailParts = [self componentsSeparatedByString:@"@"];
    return emailParts.count == 2 && [emailParts objectAtIndex:0].length > 2 && [emailParts objectAtIndex:1].length >= 2;
}


- (NSDate *)dateFromServerString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    return [dateFormatter dateFromString:self];
}

@end
