@import <Foundation/CPObject.j>
@import <AppKit/CPToolbar.j>

var EJFilterSourcesToolbarItem = @"EJFilterSourcesToolbarItem";

@implementation EJToolbarDelegate : CPObject
{
    CPPopUpButton _popUpButton;
    CPString _currentSource @accessors(property=currentSource);
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _popUpButton = [[CPPopUpButton alloc] initWithFrame:CGRectMake(0, 0, 140, 24)];
        [_popUpButton addItemWithTitle:@"All Sources"];
        [_popUpButton addItemWithTitle:@"Blog"];
        [_popUpButton addItemWithTitle:@"GitHub"];
        [_popUpButton addItemWithTitle:@"Twitter"];
        [_popUpButton setTarget:self];
        [_popUpButton setAction:@selector(changeSource:)];
        
        _currentSource = [_popUpButton titleOfSelectedItem];
    }
    
    return self;
}

- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{
    return [CPToolbarFlexibleSpaceItemIdentifier, EJFilterSourcesToolbarItem];
}

- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{
    return [CPToolbarFlexibleSpaceItemIdentifier, EJFilterSourcesToolbarItem];
}

- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:itemIdentifier];

    if (itemIdentifier === EJFilterSourcesToolbarItem)
    {
        [toolbarItem setView:_popUpButton];
        [toolbarItem setMinSize:CGSizeMake(120, 32)];
        [toolbarItem setMaxSize:CGSizeMake(120, 32)];
        [toolbarItem setLabel:"Filter Sources"];
    }
    
    return toolbarItem;
}

- (void)changeSource:(id)sender
{
    var newSource = [sender titleOfSelectedItem];
    if (_currentSource !== newSource)
    {
        [self setCurrentSource:newSource];   
    }
}

// - (void)observeValueForKeyPath:(CPString)keyPath ofObject:(id)object change:(CPDictionary)change context:(void)context
// {
//     var source = [[[change objectForKey:CPKeyValueChangeNewKey] objectAtIndex:0] key];
//     [_popUpButton addItemWithTitle:source];
//     console.log(_popUpButton);
//     console.log(source);
// }

@end