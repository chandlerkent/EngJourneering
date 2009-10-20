/*
 * AppController.j
 * EngJourneering
 *
 * Created by Chandler Kent on September 23, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

@import "Models/EJUser.j"
@import "Categories/EJ+CPString.j"
@import "Controllers/EJUserController.j"
@import "Controllers/EJSourceController.j"
@import "Views/EJSourceView.j"
@import "Views/EJToolbarDelegate.j"

@implementation AppController : CPObject
{
    EJUserController _userController;
    EJSourceController _sourceController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
        
    var toolbar = [[CPToolbar alloc] initWithIdentifier:@"Toolbar"];
    [theWindow setToolbar:toolbar];
    
    var toolbarDelegate = [[EJToolbarDelegate alloc] init];
    [toolbar setDelegate:toolbarDelegate];
    
    // Set up the controllers
    _userController = [[EJUserController alloc] init];
    _sourceController = [[EJSourceController alloc] init];
    
    // Set up views
    var splitView = [[CPSplitView alloc] initWithFrame:[contentView bounds]];
    [splitView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    [splitView setVertical:YES];
    [splitView setIsPaneSplitter:YES];
    
    var sourceView = [[EJSourceView alloc] initWithFrame:CGRectMake(0, 0, 150.0, CGRectGetHeight([contentView bounds]))];
    [sourceView setAutoresizingMask:CPViewHeightSizable | CPViewMaxXMargin];
    [splitView addSubview:sourceView];
    
    var detailView = [[EJDetailView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([contentView bounds]) - CGRectGetWidth([sourceView bounds]), CGRectGetHeight([contentView bounds]))];
    [detailView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    [splitView addSubview:detailView];
    
    [sourceView setDetailView:detailView];
    [contentView addSubview:splitView];
    
    [theWindow orderFront:self];
    
    // Set up observers
    [_userController addObserver:sourceView forKeyPath:@"users" options:CPKeyValueObservingOptionNew context:nil];
    [_userController addObserver:[EJAllUsers sharedAllUsers] forKeyPath:@"users" options:CPKeyValueObservingOptionNew context:nil];
    [_userController readUsersFromBundle];
    
    [_userController addObserver:_sourceController forKeyPath:@"currentUser" options:CPKeyValueObservingOptionNew context:nil];
    // We should have to do the following line? But we get 2 notifications if we do.
    // [_userController addObserver:detailView forKeyPath:@"currentUser" options:CPKeyValueObservingOptionNew context:nil];
    [_userController addObserver:detailView forKeyPath:@"currentUser.data" options:CPKeyValueObservingOptionNew context:nil];
    // [_userController addObserver:[EJAllUsers sharedAllUsers] forKeyPath:@"currentUser.data" options:CPKeyValueObservingOptionNew context:nil];
    [sourceView addObserver:_userController forKeyPath:@"currentUser" options:CPKeyValueObservingOptionNew context:nil];
    
    // We would like to do this, but toolbars are a bit tricky to update its contents.
    // [_sourceController addObserver:toolbarDelegate forKeyPath:@"sources" options:CPKeyValueObservingOptionNew context:nil];
    [_sourceController readSourcesFromBundle];
    
    [toolbarDelegate addObserver:detailView forKeyPath:@"currentSource" options:CPKeyValueObservingOptionNew context:nil];
}

@end
