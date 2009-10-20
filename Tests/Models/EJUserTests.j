@import "../../Models/EJUser.j"

@implementation EJUserTests : OJTestCase
{
    CPDictionary _handlesDictionary;
    CPString _displayName;
    CPDictionary _dictionary;
}

- (void)setUp
{
    _handlesDictionary = [[CPDictionary alloc] initWithObjects:[@"Chandler", @"Kent"] forKeys:[@"firstname", @"lastname"]];
    _displayName = @"Chandler Kent";
    _dictionary = [[CPDictionary alloc] initWithObjects:[_handlesDictionary, _displayName] forKeys:[@"Handles", @"Display Name"]];
}

- (void)testInitWithDictionary
{
    var chandler = [[EJUser alloc] initWithDictionary:_dictionary];
    
    [self assert:[chandler handles] equals:_handlesDictionary];
    [self assert:[chandler displayName] equals:_displayName];
    [self assert:[chandler data] equals:[]];
}

- (void)testCompare
{
    var chandler = [[EJUser alloc] initWithDictionary:_dictionary];
    var caleb = [[EJUser alloc] initWithDictionary:[[CPDictionary alloc] initWithObjects:[_handlesDictionary, @"Caleb Allen"] forKeys:[@"Handles", @"Display Name"]]];
    var derek = [[EJUser alloc] initWithDictionary:[[CPDictionary alloc] initWithObjects:[_handlesDictionary, @"Derek Hammer"] forKeys:[@"Handles", @"Display Name"]]];
    
    var users = [derek, caleb, chandler];
    
    [users sortUsingSelector:@selector(compare:)];
    
    [self assert:users equals:[caleb, chandler, derek]];
}

@end