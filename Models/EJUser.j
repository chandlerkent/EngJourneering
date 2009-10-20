@import <Foundation/CPObject.j>
@import "EJUserData.j"

@implementation EJUser : CPObject
{
    CPDictionary    _handles @accessors(property=handles, readonly);
    CPString        _displayName @accessors(property=displayName, readonly);
    CPArray         _data @accessors(property=data);
}

- (id)initWithDictionary:(CPDictionary)aDictionary
{
    self = [super init];
    
    if (self)
    {
        _data = [];
        _handles = [aDictionary objectForKey:@"Handles"];
        _displayName = [aDictionary objectForKey:@"Display Name"];
    }
    
    return self;
}

- (void)insertObject:(UserData)data inDataAtIndex:(CPInteger)index
{
    // console.log("inserting", [data message], "for user", _displayName);
    [_data insertObject:data atIndex:index];
}

- (CPComparisonResult)compare:(EJUser)otherUser
{
    if ([self displayName] < [otherUser displayName])
        return CPOrderedAscending;
    else
        return CPOrderedDescending;
}

@end

// Singleton to represent All Users
var allUsers;
@implementation EJAllUsers : EJUser
{
    CPArray _users @accessors(property=users);
}

- (id)initWithDictionary:(CPDictionary)aDictionary
{
    self = [super initWithDictionary:aDictionary];
    
    if (self)
    {
        _users = [];
    }
    
    return self;
}

+ (EJAllUsers)sharedAllUsers
{
    if (!allUsers)
    {
        allUsers = [[self alloc] initWithDictionary:[[CPDictionary alloc] initWithObjects:[@"All Users", nil] forKeys:[@"Display Name", @"Handles"]]];
    }
    
    return allUsers;
}

- (void)observeValueForKeyPath:(CPString)keyPath ofObject:(id)object change:(CPDictionary)change context:(void)context
{
    if (keyPath === @"users")
    {
        var user = [[change objectForKey:CPKeyValueChangeNewKey] objectAtIndex:0];
        if (user !== self)
        {
            [_users addObject:user];
            [user addObserver:self forKeyPath:@"data" options:CPKeyValueObservingOptionNew context:nil];
        }
    }
    else if (keyPath === @"data")
    {
        var data = [[change objectForKey:CPKeyValueChangeNewKey] objectAtIndex:0];
        [self insertObject:data inDataAtIndex:[_data count]];
    }
}

@end