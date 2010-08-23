//
//  MessagesListViewController.m
//  iAUM
//
//  Created by John Doe on 21/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMSettings.h"
#import "ThreadCell.h"
#import "ThreadCellActionView.h"
#import "ThreadListViewController.h"

@implementation ThreadListViewController

- (id)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		self.cellIdentifier = @"ThreadCell";
		self.listKeyInResponse = @"threads";
		self.listApiUrl = [iAUMSettings apiConfig:kAppSettingsApiConfigActionMessageList];
		self.title = @"Mails";
		UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"Mails" image:[UIImage imageNamed:@"tabBarMails.png"] tag:0];
		self.tabBarItem = barItem;
		[barItem release];
	}
	return self;
}

- (void) initActionView
{
	self.actionView = [[ThreadCellActionView alloc] init];
	[self.actionView release];
	[super initActionView];
}

- (void) initButtons
{
	[[self.actionView buttonForName:@"CharmRefuse"] addTarget:self action:@selector(asynchronouslyDelete) forControlEvents:UIControlEventTouchUpInside];
	//[[self.actionView buttonForName:@"ThreadRead"] addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
	[super initButtons];
}

- (void) asynchronouslyDelete
{
	if(self.swappedViewCell != -1)
	{
		[self.actionView disableButtons];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[iAUMTools queueOperation:@selector(delete:) withTarget:self withObject:[self.searchedList objectAtIndex:self.swappedViewCell]];
		NSLog(@"queue gedaoude operation");
	}
}

- (void) delete:(iAUMModelThread*)thread
{
	
}

- (void) read:(iAUMModelThread*)thread
{
	
}

- (iAUMCell*) createNewCell {
    return [[[ThreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier] autorelease];
}

- (void)fillListWithObjects:(NSArray *)objects
{
	[self.list removeAllObjects];
	for (NSDictionary* dico in objects) {
		iAUMModelThread* thread = [[iAUMModelThread alloc] initWithDictionary:dico];
		[self.list addObject:thread];
		[thread release];
	}
}

- (void)searchBar:(UISearchBar *)someSearchBar textDidChange:(NSString *)searchText
{
	[self swapActionViewBeforeSearch:NO];
	[self.searchedList removeAllObjects];
	if ([searchText isEqualToString:@""]) {
		[self.searchedList addObjectsFromArray:self.list];
		[self.tableView reloadData];
		return ;
	}
	NSUInteger searchOptions = (NSCaseInsensitiveSearch|NSLiteralSearch|NSDiacriticInsensitiveSearch);
	for (iAUMModelThread* thread in self.list) {
		NSRange range = [thread.contact.name rangeOfString:searchText options:searchOptions];
		if (range.location == NSNotFound)
			continue ;
		[self.searchedList addObject:thread];
	}
	[self.tableView reloadData];
}

-(void) displayProfile
{
	if(self.swappedViewCell != -1)
		[super displayProfile:((iAUMModelThread*)[self.searchedList objectAtIndex:self.swappedViewCell]).contact];
}

@end

