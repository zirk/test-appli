//
//  AUMListViewController.m
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMCell.h"
#import "iAUMListViewController.h"
#import "ProfileViewController.h"

@implementation iAUMListViewController

@synthesize list, loadingView, isLoading, listApiUrl, listKeyInResponse, cellIdentifier, swappedViewCell, actionView, searchBar, searchedList;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.cellIdentifier = @"iAUMCell";
		self.listKeyInResponse = nil;
		self.listApiUrl = nil;
		self.isLoading = NO;
		self.list = [[NSMutableArray alloc] init];
		self.searchedList = [[NSMutableArray alloc] init];
		self.tableView.separatorColor = [UIColor blackColor];
		self.tableView.backgroundColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.0];
		self.swappedViewCell = -1;
		self.actionView = nil;
		[self initActionView];
	}
    return self;
}

- (void) initActionView
{
	// if the subclass did not create its actionView we make the default one
	if (self.actionView == nil) {
		self.actionView = [[iAUMCellActionView alloc] init];
		[self.actionView build];
		[self.actionView placeButtons];
		[self.actionView release];
	}
	[self initButtons];
}

// implemented by subclass
-(void) initButtons
{
	[[self.actionView buttonForName:@"ViewProfile"] addTarget:self action:@selector(displayProfile) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.loadingView = [[iAUMListLoadingView alloc] init];
	[self.tableView addSubview:self.loadingView];
	[self.loadingView release];

	self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, kAppListSearchBarHeight)];
	self.searchBar.placeholder = @"Douchebag search";
	self.searchBar.delegate = self;
	self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.searchBar.tintColor = [UIColor darkGrayColor];
	//[self.tableView addSubview:self.searchBar];
	self.tableView.tableHeaderView = self.searchBar;

	self.tableView.rowHeight = kAppListCellHeight;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (self.list.count < 1)
		[self asynchronouslyLoadList];
 }

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if(scrollView.contentOffset.y < -(kAppListCellHeight)){
		[self asynchronouslyLoadList];
	}
}

- (void) asynchronouslyLoadList
{
	if (self.isLoading == YES)
		return ;
	self.isLoading = YES;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[self.loadingView isLoading:self.isLoading];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.18];
	self.tableView.contentInset = UIEdgeInsetsMake(kAppListCellHeight + (self.tableView.contentOffset.y < -kAppListCellHeight ? 0.0 : kAppListSearchBarHeight), 0.0, 0.0, 0.0);
	[UIView commitAnimations];
	[iAUMTools queueOperation:@selector(loadList) withTarget:self withObject:nil];
}

- (void) loadList
{
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:self.listApiUrl];
	
	if ([httpRequest send] == YES)
		[self performSelectorOnMainThread:@selector(refreshList:) withObject:[[httpRequest.response objectForKey:kApiResponseData] objectForKey:self.listKeyInResponse] waitUntilDone:NO];
	else
		[self performSelectorOnMainThread:@selector(refreshList:) withObject:nil waitUntilDone:NO];;
	[httpRequest release];
}

-(void) fillListWithObjects:(NSArray*)objects
{
	NSLog(@"iAUMListViewController::fillListWithObjects sayz \"but override me madde\"");
}

-(void) refreshList:(NSArray*) someList
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self fillListWithObjects:someList];
	[self.searchedList removeAllObjects];
	[self.searchedList addObjectsFromArray:self.list];
	self.isLoading = NO;
	[self.loadingView isLoading:self.isLoading];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.18];
	self.tableView.contentInset = UIEdgeInsetsZero;
	[UIView commitAnimations];
	[self refreshTabBarItem];
	[self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.searchedList count];
}

- (iAUMCell*) createNewCell
{
	return [[[iAUMCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier] autorelease];
}

- (void) initCellWithObject:(id)object
{
	NSLog(@"iAUMListController::initCellWithObject sayz \"override me bitch\"\n btw the object is %@", object);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {   
    iAUMCell *cell = (iAUMCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        cell = [self createNewCell];
		cell.actionView = self.actionView;
    }
	[cell loadObject:[self.searchedList objectAtIndex:indexPath.row]];

	// hide the potentially visible actionView of a reused cell
	if(indexPath.row != self.swappedViewCell)
		[cell displayContentView:NO];
	else
		[cell displayActionView:NO];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void) refreshTabBarItem
{
	if ([self.list count])
		self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [self.list count]];
	else
		self.tabBarItem.badgeValue = nil;
}

- (void) kickFromList:(id)object
{
	NSUInteger indexInSearchedList = [self.searchedList indexOfObject:object];
	if (indexInSearchedList == NSNotFound)
		return ;
	if (self.swappedViewCell == indexInSearchedList)
		self.swappedViewCell = -1;
	else if (self.swappedViewCell > indexInSearchedList)
		self.swappedViewCell--;
	[self.list removeObject:object];
	[self.searchedList removeObjectAtIndex:indexInSearchedList];
	NSArray* indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexInSearchedList inSection:0]];
	[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
	return ;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    iAUMCell *cell = (iAUMCell*)[self.tableView cellForRowAtIndexPath:indexPath];
	//NSLog(@"cell %@", cell.name);
	//NSLog(@"userId: %@", [[self.searchedList objectAtIndex:indexPath.row] objectForKey:@"aumId"]);
	
	// used to refresh the old swapped cell without scrolling;
	if(self.swappedViewCell != -1){
		[((iAUMCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.swappedViewCell inSection:0]]) displayContentView:YES];
		//NSLog(@"refreshed old cell %@", [((iAUMCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.swappedViewCell inSection:0]]) name]);
		//self.swappedViewCell = -1;
	}
	
	// display action view if not already shown
	if(self.swappedViewCell != indexPath.row)
	{
		self.swappedViewCell = indexPath.row;
		[cell displayActionView:YES];
	}
	else
		self.swappedViewCell = -1;

	
    // Navigation logic may go here. Create and push another view controller.
	/*
	ProfileViewController* profileViewController = [[ProfileViewController alloc] initWithUserId:[((NSDictionary*)[self.list objectAtIndex:self.list.count - indexPath.row - 1]) valueForKey:@"aumId"]];
	[profileViewController addObserver:self forKeyPath:@"kicked" options:NSKeyValueObservingOptionNew context:nil];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:profileViewController animated:YES];
	[profileViewController release];
	 */
}

-(void) displayProfile:(iAUMModelMiniProfile*)miniProfile
{
	ProfileViewController* pvc = [[ProfileViewController alloc] initWithUserId:miniProfile.aumId andName:miniProfile.name];
	[self.navigationController pushViewController:pvc animated:YES];
	[pvc release];
}

#pragma mark -
#pragma mark Search bar delegate

- (void)swapActionViewBeforeSearch:(BOOL)animated
{
	if (self.swappedViewCell != -1)
		[(iAUMCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.swappedViewCell inSection:0]] displayContentView:animated];
	self.swappedViewCell = -1;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)someSearchBar
{
	[self swapActionViewBeforeSearch:YES];
	someSearchBar.showsCancelButton = YES;
	[self.searchedList removeAllObjects];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)someSearchBar
{
	[self swapActionViewBeforeSearch:YES];
	someSearchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)someSearchBar
{
	someSearchBar.showsCancelButton = NO;
	someSearchBar.text = nil;
	[someSearchBar resignFirstResponder];
	[self.searchedList removeAllObjects];
	[self.searchedList addObjectsFromArray:self.list];
	[self swapActionViewBeforeSearch:NO];
	[self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)someSearchBar
{
	[someSearchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[self.list release];
	[self.actionView release];
	[self.loadingView release];
	[self.searchBar release];
	[self.searchedList release];
    [super dealloc];
}

@end

