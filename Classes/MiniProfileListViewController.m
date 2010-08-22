//
//  PeopleListViewController.m
//  iAUM
//
//  Created by John Doe on 21/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCell.h"
#import "MiniProfileListViewController.h"

@implementation MiniProfileListViewController

- (id)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		self.cellIdentifier = @"MiniProfileCell";
		self.listKeyInResponse = @"people";
	}
	return self;
}

- (iAUMCell*) createNewCell {
    return [[[MiniProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier] autorelease];
}

- (void)fillListWithObjects:(NSArray *)objects
{
	[self.list removeAllObjects];
	for (NSDictionary* dico in objects) {
		iAUMModelMiniProfile* miniProfile = [[iAUMModelMiniProfile alloc] initWithDictionary:dico];
		[self.list addObject:miniProfile];
		[miniProfile release];
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
	for (iAUMModelMiniProfile* miniProfile in self.list) {
		NSRange range = [miniProfile.name rangeOfString:searchText options:searchOptions];
		if (range.location == NSNotFound)
			continue ;
		[self.searchedList addObject:miniProfile];
	}
	[self.tableView reloadData];
}


-(void) displayProfile
{
	if(self.swappedViewCell != -1)
		[super displayProfile:[self.searchedList objectAtIndex:self.swappedViewCell]];
}

@end
