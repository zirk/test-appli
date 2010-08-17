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
#import "ProfileViewCell.h"

@implementation ProfileViewController

@synthesize userId, profile;

#pragma mark -
#pragma mark Initialization

- (id) initWithUserId:(NSString*) someUserId
{
	if(self = [super initWithStyle:UITableViewStyleGrouped])
	{
		self.userId = someUserId;
		self.title = @"Some 1337 profile";
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
		NSLog(@"successfuly loaded %@", self.userId);
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
		case kSectionDetails:
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
		case kSectionDetails:
			return @"Détails";
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
		switch (indexPath.row) {
			case kRowName:
			{
				cell = [tableView dequeueReusableCellWithIdentifier:@"CellName"];
				if(cell == nil){
					cell = [[ProfileViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellName"];
				}
				[self fillMainProfileCell:(ProfileViewCell*)cell];
				return cell;
			}
			default:
				break;
		}

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
		switch (indexPath.row) {
			case kRowName:
				return 300.0;
			default:
				break;
		}
	}
	return 80.0;
}

-(void)fillMainProfileCell:(ProfileViewCell*) cell
{
	cell.nameLabel.text = [self.profile objectForKey:@"name"];
	cell.ageLabel.text = [self.profile objectForKey:@"age"];
	cell.cityLabel.text = [self.profile objectForKey:@"location"];
	
	iAUMCache* cache = [[iAUMCache alloc] init];
	[cache loadImage:[self.profile objectForKey:@"mainPhotoThumb"] forObject:cell];
	[cache release];
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

