@import "EJAbstractSourceController.j"

@implementation EJGitHubController : EJAbstractSourceController
{
    CPURL _gitHubURL;
    CPArray _gitHubCommits;
}

- (id)initWithKey:(CPString)key
{
    self = [super initWithKey:key];
    
    if (self)
    {
        _gitHubCommits = [];
        _gitHubURL = [[CPURL alloc] initWithString:@"http://github.com/api/v2/json/commits/list/hammerdr/Omni-Software-Localization/master"];
    }
    
    return self;
}

- (void)fetchDataForCurrentUser
{
    if (![self currentUserHasSource] || [self currentUserHasData])
        return;

    // console.log("getting data from", _key, "for", [_currentUser displayName]);

    if ([_gitHubCommits count] <= 0)
    {
        var request = [CPURLRequest requestWithURL:_gitHubURL];
        var connection = [CPJSONPConnection sendRequest:request callback:@"callback" delegate:self];
    }
    else
    {
        [self processGitHubCommits:_gitHubCommits];
    }
}

- (void)connection:(CPJSONPConnection)connection didReceiveData:(CPJSObject)data
{
    var commits = data.commits;
    
    _gitHubCommits = commits;
    
    [self processGitHubCommits:_gitHubCommits]
}

- (void)processGitHubCommits:(CPArray)commits
{
    var user = [self currentUser];
    var gitHubHandle = [[user handles] objectForKey:[self key]];
    
    for (var i = 0; i < [commits count]; i++) {
        var commit = [commits objectAtIndex:i];
        if (commit.author.name === gitHubHandle) {
            var message = [commit.message removeTime];
            var time = [commit.message findTime];
            var date = [commit.authored_date convertFromGitHubDateToCPDate];
            var link = [CPURL URLWithString:commit.url];
            
            var dictionary = [[CPDictionary alloc] initWithObjects:[message, time, date, link, @"Github", [user displayName]]
                                                           forKeys:[@"message", @"time", @"date", @"link", @"source", @"user"]];
            
            var data = [[EJUserData alloc] initWithDictionary:dictionary];
            [user insertObject:data inDataAtIndex:[[user data] count]];
        }
    }
}

@end