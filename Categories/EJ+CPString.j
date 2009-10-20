@import <Foundation/CPString.j>

var timeRegEx = new RegExp("t:(\\d+)h(\\d+)m", "gi");

@implementation CPString (EJ)

- (CPNumber)findTime
{    
    var time = 0;
    
    var matches = timeRegEx.exec(self);
    if (matches) {
        time = 60 * parseInt(matches[1]) + parseInt(matches[2]);
    }
    
    return time;
}

- (CPString)removeTime
{
    return self.replace(timeRegEx, "");
}

- (CPString)removeOccurencesOfString:(CPString)removeString
{
    return [self stringByReplacingOccurrencesOfString:removeString withString:""];
}

- (CPDate)convertFromGitHubDateToCPDate
{
    var dayThenTime = [self componentsSeparatedByString:@"T"];
    
    if (dayThenTime) {
        var date = [dayThenTime[0] componentsSeparatedByString:@"-"];
        var time = [dayThenTime[1] componentsSeparatedByString:@":"];
        
        if (date && time) {
            return new Date(date[0], date[1] - 1, date[2], time[0], time[1], time[2].substring(0, 2));
        }
    }
    
    return 0;
}

@end