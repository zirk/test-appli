//
//  SettingsViewController.m
//  iAUM
//
//  Created by dirk on 10/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAUMConstants.h"
#import "SettingsViewController.h"
#import "SettingsDetailCell.h"
#import "iAUMAppDelegate.h"
#import "iAUMSettings.h"

@implementation SettingsViewController
@synthesize cells;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    //NSLog(@"style %@", @"prout");
	if ((self = [super initWithStyle:style])) {
		self.title = @"Préférences";
		[self initCells];
		[self initTabBar];
    }
    return self;
}

- (void) initCells
{
	SettingsDetailCell* loginCell = [[SettingsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	loginCell.textField.placeholder = kAppSettingsLogin;
	loginCell.textField.text = [iAUMSettings get:kAppSettingsLogin];
	loginCell.textField.delegate = self;
	SettingsDetailCell* passwordCell = [[SettingsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	passwordCell.textField.placeholder = kAppSettingsPassword;
	passwordCell.textField.secureTextEntry = YES;
	passwordCell.textField.text = [iAUMSettings get:kAppSettingsPassword];
	passwordCell.textField.returnKeyType = UIReturnKeyDone;
	passwordCell.textField.delegate = self;
	self.cells = [[NSArray alloc] initWithObjects:loginCell, passwordCell, nil];
	[loginCell release];
	[passwordCell release];	
}

-(void) initTabBar
{
	UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"Préférences" image:[UIImage imageNamed:@"tabBarSettings.png"] tag:0];
	self.tabBarItem = barItem;
	[barItem release];
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.view = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}*/


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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.cells count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = @"sap";
    // Configure the cell...
    */
    return [self.cells objectAtIndex:indexPath.row];
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
#pragma mark UITextFieldDelegate Protocol

//  Sets the label of the keyboard's return key to 'Done' when the insertion
//  point moves to the table view's last field.
//
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

//  UITextField sends this message to its delegate after resigning
//  firstResponder status. Use this as a hook to save the text field's
//  value to the corresponding property of the model object.
//
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[iAUMSettings set:textField.placeholder withValue:textField.text];
}

//  UITextField sends this message to its delegate when the return key
//  is pressed. Use this as a hook to navigate back to the list view 
//  (by 'popping' the current view controller, or dismissing a modal nav
//  controller, as the case may be).
//
//  If the user is adding a new item rather than editing an existing one,
//  respond to the return key by moving the insertion point to the next cell's
//  textField, unless we're already at the last cell.
//
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	if ([textField returnKeyType] != UIReturnKeyDone)
    {
		NSUInteger index = [self.cells indexOfObjectIdenticalTo:textField.superview.superview] + 1;
        [((SettingsDetailCell*)[self.cells objectAtIndex:index]).textField becomeFirstResponder];
    }
	else {
		[iAUMSettings set:textField.placeholder withValue:textField.text];
		HttpRequest* httpRequest = [[HttpRequest alloc] initWithUrl:@"/"];		
		if ([httpRequest send] == YES)
		{
			NSString* aumId = [[httpRequest.response objectForKey:kApiResponseExtra] objectForKey:@"aumId"];
			[iAUMSettings set:kAppSettingsAumId withValue:aumId];
			//[textField performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
			[textField resignFirstResponder];
			if (aumId != nil)
				NSLog(@"successfuly identified %@, it's a %d (0=Girl,1=Boy,2=Alien)", aumId, [iAUMTools getUsersSex:aumId]);
			else
				NSLog(@"could not identify, perhaps bad login/password ?");
		}
		else {
			NSLog(@"Error while identifying");
		}
		[httpRequest release];
	}

    return YES;
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
	[self.cells release];
    [super dealloc];
}


@end

