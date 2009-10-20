@import <AppKit/CPCollectionView.j>

@import "EJDetailView.j"
@import "../Models/EJUser.j"

@implementation EJSourceView : CPView
{
    EJDetailView detailView @accessors;
    CPCollectionView usersView;
    EJUser _currentUser @accessors(property=currentUser);
}

- (id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    
    if (self)
    {        
        var userListView = [[CPCollectionViewItem alloc] init];
        [userListView setView:[[UserListView alloc] initWithFrame:CGRectMakeZero()]];
        
        usersView = [[CPCollectionView alloc] initWithFrame:rect];
        [usersView setItemPrototype:userListView];
        [usersView setMaxNumberOfColumns:1];
        [usersView setVerticalMargin:0.0];
        [usersView setMinItemSize:CGSizeMake(100.0, 40.0)];
        [usersView setMaxItemSize:CGSizeMake(1000000.0, 40.0)];
        [usersView setDelegate:self];
        [usersView setAutoresizingMask:CPViewWidthSizable];
        
        [self addSubview:usersView];
        [self setBackgroundColor:[CPColor colorWithCalibratedRed:0.840 green:0.868 blue:0.899 alpha:1.000]];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(CPString)keyPath ofObject:(id)object change:(CPDictionary)change context:(void)context
{
    if (keyPath === @"users") {
        [usersView setContent:[object users]];
        [usersView reloadContent];
    }
}

- (void)collectionViewDidChangeSelection:(CPCollectionView)aCollectionView
{
    var listIndex = [[aCollectionView selectionIndexes] firstIndex];
    
    var users = [usersView content];
    
    var user = [users objectAtIndex:listIndex];
    
    if (user !== _currentUser)
    {
        [self setCurrentUser:user];
    }
}

@end

@implementation UserListView : CPView
{
    CPTextField label;
    CPView highlightView;
    // CountView _countView;
}

- (void)setRepresentedObject:(JSObject)anObject
{
    if (!label)
    {
        label = [[CPTextField alloc] initWithFrame:CGRectInset([self bounds], 4, 4)];
        
        [label setFont:[CPFont systemFontOfSize:16.0]];
        [label setTextShadowColor:[CPColor whiteColor]];
        [label setTextShadowOffset:CGSizeMake(0, 1)];
 
        [self addSubview:label];
    }

    [label setStringValue:[anObject displayName]];
    [label sizeToFit];
 
    [label setFrameOrigin:CGPointMake(10,CGRectGetHeight([label bounds]) / 2.0)];
    
    // if (!_countView)
    //     {
    //         _countView = [[CountView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    //         [self addSubview:_countView];
    //     }
}
 
- (void)setSelected:(BOOL)flag
{
    if (!highlightView)
    {
        highlightView = [[CPView alloc] initWithFrame:CGRectCreateCopy([self bounds])];
        [highlightView setBackgroundColor:[CPColor colorWithCalibratedRed:0.561 green:0.631 blue:0.761 alpha:1.000]];
        [highlightView setAutoresizingMask:CPViewWidthSizable];
    }
 
    if (flag)
    {
        [self addSubview:highlightView positioned:CPWindowBelow relativeTo:label];
        [label setTextColor:[CPColor whiteColor]];    
        [label setTextShadowColor:[CPColor blackColor]];
    }
    else
    {
        [highlightView removeFromSuperview];
        [label setTextColor:[CPColor blackColor]];
        [label setTextShadowColor:[CPColor whiteColor]];
    }
}

@end

@implementation CountView : CPView
{
    // CPInteger _count @accessors(property=count);
    CPTextField _countDisplay;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _countDisplay = [CPTextField labelWithTitle:@"0"];
        [_countDisplay setFont:[CPFont boldSystemFontOfSize:14.0]];
        [_countDisplay setTextColor:[CPColor whiteColor]];
        [_countDisplay sizeToFit];
        
        [self addSubview:_countDisplay];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    var path = [CPBezierPath bezierPathWithOvalInRect:rect];
    
    [[CPColor colorWithCalibratedRed:0.561 green:0.631 blue:0.761 alpha:1.000] set];
    
    [path stroke];
}

@end