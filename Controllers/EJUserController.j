@import <Foundation/CPObject.j>
@import "../Models/EJUser.j"

/*
 * Initalizes and tracks the users.
 */
@implementation EJUserController : CPObject
{
    CPArray _users @accessors(property=users, readonly);
    EJUser _currentUser @accessors(property=currentUser);
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _users = [];
    }
    
    return self;
}

- (void)readUsersFromBundle
{    
    var bundle = [CPBundle mainBundle];
    var usersFromBundle = [bundle objectForInfoDictionaryKey:@"EJUsers"];
    
    for (var i = 0; i < [usersFromBundle count]; i++)
    {
        var user = [[EJUser alloc] initWithDictionary:[usersFromBundle objectAtIndex:i]];
        [self insertObject:user inUsersAtIndex:i];
    }
    
    // Want alphabetical order
    [_users sortUsingSelector:@selector(compare:)];
    [self insertObject:[EJAllUsers sharedAllUsers] inUsersAtIndex:[_users count]];
}

- (void)insertObject:(id)anObject inUsersAtIndex:(CPInteger)anIndex
{
    [_users addObject:anObject];
}

- (void)observeValueForKeyPath:(CPString)keyPath ofObject:(id)object change:(CPDictionary)change context:(void)context
{
    switch (keyPath)
    {
        case @"currentUser":
            var user = [change objectForKey:CPKeyValueChangeNewKey];
            [self setCurrentUser:user];
            break;
        
        default:
            console.warn("Unhandled keyPath");
            break;
    }
}

@end