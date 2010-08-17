//
//  AUMListViewController.m
//  iAUM
//
//  Created by dirk on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MiniProfileCellActionViewCharms.h"
#import "MiniProfileCell.h"
#import "iAUMListViewController.h"

@implementation iAUMListViewController

@synthesize list, loadingIndicator, isLoading, listApiUrl, swappedViewCell, actionView;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.isLoading = NO;
		self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(50, 50, 40.0, 40.0)];
		self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		self.loadingIndicator.hidesWhenStopped = YES;
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
		self.actionView = [[MiniProfileCellActionView alloc] init];
		[self.actionView build];
		[self.actionView placeButtons];
		[self.actionView release];
	}
	self.actionView.tag = MiniProfileViewTypeAction;
	[self initButtons];
}

- (void) asynchronouslyLoadList
{
	if (self.isLoading == YES)
		return ;
	self.isLoading = YES;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[self.loadingIndicator startAnimating];	
	[iAUMTools queueOperation:@selector(loadList) withTarget:self withObject:nil];
}

- (void) loadList
{
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:self.listApiUrl];

	if ([httpRequest send] == YES)
		[self performSelectorOnMainThread:@selector(refreshList:) withObject:[[httpRequest.response objectForKey:@"data"] objectForKey:@"people"] waitUntilDone:NO];
	else
		[self performSelectorOnMainThread:@selector(refreshList:) withObject:nil waitUntilDone:NO];;
	[httpRequest release];
}

-(void) refreshList:(NSArray*) someList
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self.loadingIndicator stopAnimating];
	self.list = [NSMutableArray arrayWithArray:someList];
	self.isLoading = NO;
	[self refreshTabBarItem];
	[self.tableView reloadData];
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
	[self.view addSubview:self.loadingIndicator];
	self.tableView.rowHeight = kAppListCellHeight;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	NSLog(@"vertical offset: %f", scrollView.contentOffset.y);
	if(scrollView.contentOffset.y < -kAppListCellHeight * 1.5){
		[self asynchronouslyLoadList];
	}
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.list count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MiniProfileCell *cell = (MiniProfileCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MiniProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.actionView = self.actionView;
    }
	[cell loadFromDictionary:(NSDictionary*)[self.list objectAtIndex:indexPath.row]];

	// hide the potentially visible actionView of a reused cell
	if(indexPath.row != self.swappedViewCell)
		[cell displayProfileViewWithTransition:NO];
	else
		[cell displayActionViewWithTransition:NO];
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

- (void) kickFromListWithId:(NSString*)aumId
{
	if(self.swappedViewCell > -1) {
		[self.list removeObjectAtIndex:self.swappedViewCell];
		NSUInteger indexes[] = {0, self.swappedViewCell};
		NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
		[self refreshTabBarItem];
	}
	self.swappedViewCell = -1;
	/*
	for (NSDictionary* miniProfile in self.list) {
		if ([aumId compare:[miniProfile objectForKey:@"aumId"]] == NSOrderedSame)
		{
			[self.list removeObject:miniProfile];
			[self refreshTableView];
			self.swappedViewCell = -1;
			break ;
		}
	}	*/
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context
{
	NSLog(@"keyPath : %@\nobject : %@\nchange : %@", keyPath, object, change);
	if ([keyPath compare:@"kicked"] == NSOrderedSame)
		[self kickFromListWithId:((ProfileViewController*)object).userId];
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MiniProfileCell *cell = (MiniProfileCell*)[tableView cellForRowAtIndexPath:indexPath];
	NSLog(@"cell %@", cell.name);
	NSLog(@"userId: %@", [[self.list objectAtIndex:indexPath.row] objectForKey:@"aumId"]);
	
	// used to refresh the old swapped cell without scrolling;
	if(self.swappedViewCell != -1){
		[((MiniProfileCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.swappedViewCell inSection:0]]) displayProfileViewWithTransition:YES];
		NSLog(@"refreshed old cell %@", [((MiniProfileCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.swappedViewCell inSection:0]]) name]);
		//self.swappedViewCell = -1;
	}
	
	// display action view if not already shown
	if(self.swappedViewCell != indexPath.row)
	{
		self.swappedViewCell = indexPath.row;
		[cell displayActionViewWithTransition:YES];
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


-(void) displayProfile
{
	if(self.swappedViewCell != -1)
	{
		ProfileViewController* pvc = [[ProfileViewController alloc] initWithUserId:[[self.list objectAtIndex:self.swappedViewCell] objectForKey:@"aumId"]];
		[self.navigationController pushViewController:pvc animated:YES];
		[pvc release];
	}
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
    [super dealloc];
}

@end

