@import "../../Models/EJUserData.j"
@import "../../Models/EJUser.j"

@implementation EJUserDataTests : OJTestCase
{
    CPDictionary _dictionary;
    CPDate _date;
    EJUser _user;
}

- (void)setUp
{
    _date = [[CPDate alloc] initWithTimeIntervalSince1970:123456789];
    _dictionary = [[CPDictionary alloc] initWithObjects:[@"message", 120, _date, @"source", @"user", @"link"] forKeys:[@"message", @"time", @"date", @"source", @"user", @"link"]];
}

- (void)testInitWithDictionary
{
    var data = [[EJUserData alloc] initWithDictionary:_dictionary];
    
    [self assert:[data message] equals:@"message"];
    [self assert:[data time] equals:120];
    [self assert:[data date] equals:_date];
    [self assert:[data source] equals:@"source"];
    [self assert:[data user] equals:@"user"];
    [self assert:[data link] equals:@"link"];
}

- (void)testCompare
{
    var data1 = [[EJUserData alloc] initWithDictionary:_dictionary];
    [_dictionary setObject:[[CPDate alloc] initWithTimeIntervalSince1970:123] forKey:@"date"];
    var data2 = [[EJUserData alloc] initWithDictionary:_dictionary];
    [_dictionary setObject:[[CPDate alloc] initWithTimeIntervalSince1970:2345678910] forKey:@"date"];
    var data3 = [[EJUserData alloc] initWithDictionary:_dictionary];
    
    var datum = [data1, data2, data3];
    
    [datum sortUsingSelector:@selector(compare:)];
    
    [self assert:datum equals:[data3, data1, data2]];
}

-(void)testNicelyFormattedString
{
    [_dictionary setObject:_date forKey:@"date"];
    var data = [[EJUserData alloc] initWithDictionary:_dictionary];
    
    [self assert:[data nicelyFormattedDate] equals:_date.toUTCString()];
}

@end