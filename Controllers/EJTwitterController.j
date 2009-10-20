@import "EJAbstractSourceController.j"

var ProjectOSL = "projectosl";

@implementation EJTwitterController : EJAbstractSourceController
{
    CPDictionary _connections;
}

- (CPURL)twitterURLForCurrentUser
{
    return [[CPURL alloc] initWithString:@"http://twitter.com/status/user_timeline/" + [[_currentUser handles] objectForKey:_key] + ".json?count=100"];
}

- (void)fetchDataForCurrentUser
{
    if (![self currentUserHasSource] || [self currentUserHasData])
        return;

    // console.log("getting data from", _key, "for", [_currentUser displayName]);
    if (!_connections)
    {
        _connections = [CPDictionary dictionary];
    }
    
    var url = [self twitterURLForCurrentUser];
    var request = [CPURLRequest requestWithURL:url];
    var connection = [CPJSONPConnection sendRequest:request callback:@"callback" delegate:self];
    [_connections setObject:_currentUser forKey:connection];
}

- (void)connection:(CPJSONPConnection)connection didReceiveData:(CPJSObject)tweets
{
    var user = [_connections objectForKey:connection];
    
    for (var i = 0; i < tweets.length; i++)
    {
        var tweet = [tweets objectAtIndex:i];
        if ((tweet.in_reply_to_screen_name === ProjectOSL) || (tweet.text.indexOf(ProjectOSL) >= 0))
        {
            var message = [[tweet.text removeOccurencesOfString:"@" + ProjectOSL] removeTime];
            var time = [tweet.text findTime];
            var date = [[CPDate alloc] initWithString:tweet.created_at];
            var link = [CPURL URLWithString:@"http://www.twitter.com/" + [[user handles] objectForKey:[self key]] + "/status/" + tweet.id];
            
            var dictionary = [[CPDictionary alloc] initWithObjects:[message, time, date, link, @"Twitter", [user displayName]]
                                                           forKeys:[@"message", @"time", @"date", @"link", @"source", @"user"]];
            
            var data = [[EJUserData alloc] initWithDictionary:dictionary];
            [user insertObject:data inDataAtIndex:[[user data] count]];
        }
    }
    
    [_connections removeObjectForKey:connection];
}

@end