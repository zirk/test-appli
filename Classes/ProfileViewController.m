//
//  _ProfileViewController.m
//  iAUM
//
//  Created by dirk on 16/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "iAUMTools.h"
#import "iAUMCache.h"
#import "HttpRequest.h"
#import "iAUMConstants.h"

@implementation ProfileViewController

@synthesize userId, profile;

#pragma mark -
#pragma mark Initialization

- (id) initWithUserId:(NSString*) someUserId andName:(NSString*)name
{
	if(self = [super initWithStyle:UITableViewStyleGrouped])
	{
		self.userId = someUserId;
		self.title = name;
		NSLog(@"userid: %@", self.userId);
	}
	return self;
}

- (void) asynchronouslyLoadProfile
{
	NSLog(@"downloading profile");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[iAUMTools queueOperation:@selector(loadProfile) withTarget:self withObject:nil];
}

- (void) loadProfile
{
	NSLog(@"in loadProfile for %@", self.userId);
	HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/profiles/visit"];
	[httpRequest addParam:@"aumId" value:self.userId];
	
	if ([httpRequest send] == YES)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		//[self performSelectorOnMainThread:@selector(refuse) withObject:[[[httpRequest.response objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"guys"] waitUntilDone:NO];
		self.profile = [httpRequest.response objectForKey:@"data"];
		
		[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
		NSLog(@"successfuly loaded %@ whose name is %@", self.userId, [self.profile objectForKey:@"name"]);
	}
	else {
		NSLog(@"Failed at loading %@ ", self.userId);
	}
	[httpRequest release];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/*
 - (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self asynchronouslyLoadProfile];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
    return NUM_SECTIONS;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
		case kSectionGeneralInfos:
			return NUM_ROWS_GENERAL_INFO;
		case kSectionPhysical:
			return NUM_ROW_DETAILS;
		case kSectionAccessories:
			return NUM_ROW_ACCESSORIES;
		case kSectionFunctions:
			return NUM_ROW_FUNCTIONS;
		case kSectionRivales:
			return NUM_ROW_RIVALES;
		case kSectionPhoto:
			return NUM_ROW_PHOTOS;
		default:
			return 0;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section) {
		case kSectionGeneralInfos:
			return @"Infos générales";
		case kSectionPhysical:
			return @"Physique";
		case kSectionFunctions:
			return @"Fonctions";
		case kSectionAccessories:
			return @"Accessoires";
		case kSectionPhoto:
			return @"Photos";
		case kSectionRivales:
			return @"Rivales";
		default:
			return @"N/A";
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = nil;
	
	if(indexPath.section == kSectionGeneralInfos){
		cell = [tableView dequeueReusableCellWithIdentifier:@"CellDetails"];
		if(cell == nil){
			cell = [[ProfileDetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellDetails"];
		}
		[self fillMainProfileCell:(ProfileDetailsViewCell*)cell];
		return cell;
	}
	else if (indexPath.section == kSectionPhysical) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"CellList"];
		if(cell == nil){
			cell = [[ProfileListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellList"];
		}
		[self fillPhysicalViewCell:(ProfileListViewCell*)cell];
		return cell;
	}
    else if (indexPath.section == kSectionAccessories) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"CellList"];
		if(cell == nil){
			cell = [[ProfileListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellList"];
		}
		[self fillAccessoriesViewCell:(ProfileListViewCell*)cell];
		return cell;
	}
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    }
	cell.textLabel.text = @"N/A";
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == kSectionGeneralInfos){
		return [self computeDetailsCellHeight];
	}
	else if(indexPath.section == kSectionPhysical )
	{
		// only one cell
		return [self computePhysicalCellHeight];
	}
	else if (indexPath.section == kSectionFunctions) 
	{
		return [self computeFunctionsCellHeight];
	}
	else if (indexPath.section == kSectionAccessories)
	{
		
		return [self computeAccessoriesCellHeight];
	}
	return 80.0;
}

-(CGFloat)computeDetailsCellHeight
{
	return 120.0;
}

-(CGFloat)computePhysicalCellHeight
{
	NSArray* fields = [[NSArray alloc] initWithObjects:@"eyes", @"hair", @"size", @"fur", @"origins", @"style", nil];
	return [self heightForFields:fields];
	[fields release];
}

-(CGFloat)computeFunctionsCellHeight
{
	NSArray* fields = [[NSArray alloc] initWithObjects:@"alcohol", @"bathroom", @"bed", @"extra", @"food", @"hifi", nil];
	return [self heightForFields:fields];
	[fields release];
}

-(CGFloat)computeAccessoriesCellHeight
{
	NSArray* fields = [[NSArray alloc] initWithObjects:@"hobbies", @"housing", @"job", @"locomotion", @"pets", @"smoke", nil];
	return [self heightForFields:fields];
	[fields release];
}

-(CGFloat)heightForFields:(NSArray*) fields
{
	CGFloat height = 20.0; // minimum size for the cell
	for (NSString* fieldName in fields) {
		if ([self.profile objectForKey:fieldName] != nil) {
			height += kPhysicalCellFieldHeight;
		}
	}
	return height;
}
				
-(void)fillMainProfileCell:(ProfileDetailsViewCell*) cell
{
	cell.nameLabel.text = [self.profile objectForKey:@"name"];
	cell.ageLabel.text = [self.profile objectForKey:@"age"];
	cell.cityLabel.text = [self.profile objectForKey:@"location"];
	cell.popularityLabel.text = [self.profile objectForKey:@"popularity"];
	
	iAUMCache* cache = [[iAUMCache alloc] init];
	[cache loadImage:[self.profile objectForKey:@"mainPhotoThumb"] forObject:cell];
	[cache release];
}

-(void)fillPhysicalViewCell:(ProfileListViewCell*) cell
{
	[cell setField:@"Yeux" withValue:[self.profile objectForKey:@"eyes"]];
	[cell setField:@"Cheveux" withValue:[self.profile objectForKey:@"hair"]];
	[cell setField:@"Mensurations" withValue:[self.profile objectForKey:@"size"]];
	[cell setField:@"Pilosité" withValue:[self.profile objectForKey:@"fur"]];
	[cell setField:@"Origines" withValue:[self.profile objectForKey:@"origins"]];
	[cell setField:@"Style" withValue:[self.profile objectForKey:@"style"]];
}

-(void)fillAccessoriesViewCell:(ProfileListViewCell*) cell
{
	[cell setField:@"1" withValue:[self.profile objectForKey:@"hobbies"]];
	[cell setField:@"2" withValue:[self.profile objectForKey:@"housing"]];
	[cell setField:@"3" withValue:[self.profile objectForKey:@"job"]];
	[cell setField:@"4" withValue:[self.profile objectForKey:@"locomotion"]];
	[cell setField:@"5" withValue:[self.profile objectForKey:@"pets"]];
	[cell setField:@"6" withValue:[self.profile objectForKey:@"smoke"]];
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
    [super dealloc];
}


@end

