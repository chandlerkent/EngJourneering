@import "EJAbstractSourceController.j"

@implementation EJRSSController : EJAbstractSourceController
{
    CPDictionary _connections;
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
    
    var url = [[CPURL alloc] initWithString:[[_currentUser handles] objectForKey:_key]];
    var request = [CPURLRequest requestWithURL:url];
    var connection = [CPJSONPConnection sendRequest:request callback:@"callback" delegate:self];
    [_connections setObject:_currentUser forKey:connection];
}

- (void)connection:(CPJSONPConnection)connection didReceiveData:(CPJSObject)data
{
	var user = [_connections objectForKey:connection];
    
    var posts = data.items;
    
    for (var i = 0; i < [posts count]; i++)
    {
        var post = [posts objectAtIndex:i];
        
        var message = post.title;
        var link = [CPURL URLWithString:post.link];
        var date = [[CPDate alloc] initWithString:post.date];
        var dictionary = [[CPDictionary alloc] initWithObjects:[message, 0, date, link, @"Blog", [user displayName]]
                                                       forKeys:[@"message", @"time", @"date", @"link", @"source", @"user"]];
        
        var data = [[EJUserData alloc] initWithDictionary:dictionary];
        [user insertObject:data inDataAtIndex:[[user data] count]];
    }
}

@end