@import <Foundation/CPObject.j>

@implementation EJUserData : CPObject
{
    CPString message @accessors(readonly);
    CPNumber time @accessors(readonly);
    CPDate date @accessors(readonly);
    CPString source @accessors(readonly);
    CPString user @accessors(readonly);
    CPURL link @accessors(readonly);
}

- (id)initWithDictionary:(CPDictionary)aDictionary
{
    self = [super init];
    
    if (self)
    {
        message = [aDictionary objectForKey:@"message"];
        time = [aDictionary objectForKey:@"time"];
        date = [aDictionary objectForKey:@"date"];
        source = [aDictionary objectForKey:@"source"];
        user = [aDictionary objectForKey:@"user"];
        link = [aDictionary objectForKey:@"link"];
    }
    
    return self;
}

- (CPString)nicelyFormattedDate
{
    return date.toUTCString();
}

- (unsigned)compare:(UserData)other
{
    if ([self date] < [other date])
    {
        return CPOrderedDescending;
    } else if ([self date] > [other date]) {
        return CPOrderedAscending;
    } else {
        return CPOrderedSame;
    }
}

@end