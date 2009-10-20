@import <AppKit/CPCollectionView.j>

@import "../Models/EJUser.j"

@implementation EJDetailView : CPView
{
    CPCollectionView details;
    CPScrollView scrollView;
    CPArray _currentData;
    CPString _currentSource;
    CPInteger _count;
}

- (id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    
    if (self)
    {
        _currentData = [];
        _currentSource = nil;
        _count = 0;
        
        var dataView = [[CPCollectionViewItem alloc] init];
        [dataView setView:[[UserDataView alloc] initWithFrame:CGRectMakeZero()]];
        
        details = [[CPCollectionView alloc] initWithFrame:rect];
        [details setItemPrototype:dataView];
        [details setMaxNumberOfColumns:1];
        [details setVerticalMargin:0.0];
        [details setMinItemSize:CGSizeMake(500.0, 42.0)];
        [details setMaxItemSize:CGSizeMake(10000.0, 42.0)];
        [details setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [details setDelegate:self];
        
        scrollView = [[CPScrollView alloc] initWithFrame:rect];
        [scrollView setAutohidesScrollers:YES];
        [scrollView setDocumentView:details];
        [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        
        [self addSubview:scrollView];
        [self setBackgroundColor:[CPColor colorWithCalibratedWhite:0.656 alpha:1.000]];
    }
    
    return self;
}

- (void)reloadContent
{
    [[scrollView contentView] scrollToPoint:CPMakePoint(0,0)];
    var contentToLoad = [];
    if (!_currentSource || _currentSource === @"All Sources")
    {
        contentToLoad = _currentData;
    }
    else
    {
        for (var i = 0; i < [_currentData count]; i++)
        {
            var data = [_currentData objectAtIndex:i];
            if ([data source].toLowerCase() === _currentSource.toLowerCase())
            {
                [contentToLoad addObject:data];
            }
        }
    }
    
    [contentToLoad sortUsingSelector:@selector(compare:)];
    [details setContent:contentToLoad];
    [details reloadContent];
}

- (void)observeValueForKeyPath:(CPString)keyPath ofObject:(id)object change:(CPDictionary)change context:(void)context
{
    switch (keyPath)
    {
        case @"currentUser":        
        case @"currentUser.data":
            // called when data is added to the current user.
            var user = [object currentUser];
            var data = [user data];
            _currentData = data;
            [self reloadContent];
            console.log(++_count);
            break;
            
        case @"currentSource":
            _currentSource = [object currentSource];
            [self reloadContent];
            break;
        
        default:
            console.warn("Unhandled keyPath in EJDetailView.j");
            break;
    }
}

- (void)collectionViewDidChangeSelection:(CPCollectionView)aCollectionView
{
    var listIndex = [[aCollectionView selectionIndexes] firstIndex];
    
    var link = [[[aCollectionView content] objectAtIndex:listIndex] link];
    
    window.open([link absoluteString]);
}

@end

@implementation UserDataView : CPView
{
    CPTextField dateAndTime;
    CPTextField message;
    CPTextField sourceAndUser;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setBackgroundColor:[CPColor colorWithCalibratedWhite:0.926 alpha:1.000]];
        [self setAutoresizingMask:CPViewWidthSizable];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    var bPath = [CPBezierPath bezierPath];
    
	[[CPColor grayColor] set];
	
	[bPath setLineWidth:2];
	
	[bPath moveToPoint:CPMakePoint(rect.origin.x, rect.origin.y + rect.size.height)];
	[bPath lineToPoint:CPMakePoint(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height)];
	[bPath stroke];
}

- (void)setRepresentedObject:(JSObject)anObject
{
    if (!message)
    {
        message = [[CPTextField alloc] initWithFrame:CGRectInset([self bounds], 10, 10)];
        
        [message setFont:[CPFont systemFontOfSize:16.0]];
        [message setTextShadowColor:[CPColor whiteColor]];
        [message setTextShadowOffset:CGSizeMake(0, 1)];
 
        [self addSubview:message];
    }
    
    [message setStringValue:[anObject message]];
    [message sizeToFit];
    [message setFrameOrigin:CGPointMake(10,CGRectGetHeight([message bounds]) / 2.0)];
    
    if (!dateAndTime)
    {
        dateAndTime = [[CPTextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
        
        [dateAndTime setFont:[CPFont systemFontOfSize:10.0]];
        [dateAndTime setTextColor:[CPColor grayColor]];
        [dateAndTime setAutoresizingMask:CPViewMaxXMargin | CPViewMaxYMargin];
        
        [self addSubview:dateAndTime];
    }
    
    [dateAndTime setStringValue:[anObject nicelyFormattedDate] + " for " + [anObject time] + " minutes."];
    [dateAndTime sizeToFit];
    
    if (!sourceAndUser)
    {
        sourceAndUser = [[CPTextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]))];
        
        [sourceAndUser setFont:[CPFont systemFontOfSize:10.0]];
        [sourceAndUser setTextColor:[CPColor grayColor]];
        [sourceAndUser setAutoresizingMask:CPViewMinXMargin | CPViewMinYMargin];
        [self addSubview:sourceAndUser];
    }
    
    [sourceAndUser setStringValue:"Posted by " + [anObject user] + " to " + [anObject source]];
    [sourceAndUser sizeToFit];
    [sourceAndUser setFrameOrigin:CGPointMake(CGRectGetWidth([self bounds]) - CGRectGetWidth([sourceAndUser bounds]), CGRectGetHeight([self bounds]) - CGRectGetHeight([sourceAndUser bounds]))];
}

@end