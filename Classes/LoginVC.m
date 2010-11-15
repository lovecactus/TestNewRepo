//
//  LoginVC.m
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-6.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import "LoginVC.h"
#import	"Constants.h"
#import	"DaddysDollarAppDelegate.h"
#import "Global.h"
#import	"SetupVC.h"

@implementation LoginVC


#pragma mark -
#pragma mark Initialize Data
- (void)InitChildren{
	if (GlobalChildInfo == nil) {
		GlobalChildInfo = [[NSMutableDictionary alloc] init];
		[GlobalChildInfo setObject:@"" forKey:@"Name"];
		[GlobalChildInfo setObject:[NSNumber numberWithInt:10] forKey:@"Melon"];
		NSMutableArray *ChildItems = [[NSMutableArray alloc] init];
		
		[GlobalChildInfo setObject:ChildItems forKey:@"Items"];
		//[defs setObject:GlobalChildInfo forKey:@"ChildInfo"];
		//[defs synchronize];
		//[GlobalChildInfo release];
		//GlobalChildInfo = [defs objectForKey:@"ChildInfo"];

		SetupVC *setNameVC = [[SetupVC alloc] init];
		UINavigationController *setNameNVC = [[UINavigationController alloc] initWithRootViewController:setNameVC];
		[self presentModalViewController:setNameNVC animated:YES];
	}else {
	//	GlobalChildInfo = [defs objectForKey:@"ChildInfo"];
	}
	
}

#pragma mark Initialization
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/
- (id)init{
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.navigationItem.title = @"Daddy's Dollar";
	}
	return self;
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
	[self InitChildren];
	NSLog(@"global child info:%@",GlobalChildInfo);
	self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
	[self.tableView reloadData];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		NSString *aboutStr;
		aboutStr = [NSString stringWithFormat:@"\nWelcome to Daddy's dollar (alpha)! Please enjoy the happy relationship between you and your children!"];
		CGSize maxSize = CGSizeMake(320-36, 100);
		CGSize size = [aboutStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
		UILabel *aboutStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 320-36, size.height)];
		aboutStringLabel.backgroundColor = [UIColor clearColor];
		aboutStringLabel.font = [UIFont systemFontOfSize:14];
		aboutStringLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
		aboutStringLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		aboutStringLabel.textColor = [UIColor darkGrayColor];
		aboutStringLabel.text = aboutStr;
		aboutStringLabel.numberOfLines = 0;
		
		UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 10)];
		[tmpView addSubview:aboutStringLabel];
		[aboutStringLabel release];
		
		return [tmpView autorelease];		
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	CGFloat titleHeight = 0.f;
	switch (section) {
		case 0:
			titleHeight = 100.f;
			break;
		default:
			titleHeight = 0.f;
			break;
	}
	return titleHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = @"I'm Parent";
			break;
		case 1:
			cell.textLabel.text = [NSString stringWithFormat:@"I'm %@",[GlobalChildInfo objectForKey:@"Name"]];
			break;
		default:
			break;
	}
    // Configure the cell...
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
#pragma mark Alert view delegate
- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex {
	//dummy, only hanle 'OK' here.
	switch (alertView.tag) {
		case LOGINVIEW+ALERT_LOGINPARENT_TAG:
			[DaddysDollarAppDelegate ParentEntrance:self.navigationController];
			break;
		case LOGINVIEW+ALERT_LOGINCHILD_TAG:
			[DaddysDollarAppDelegate ChildEntrance:self.navigationController];
			break;
		default:
			break;
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
		case 0:
			//push in parent's view controller tabs
			NSLog(@"Enter daddy's dollar");
			UIAlertView *parentAlert = [[UIAlertView alloc] initWithTitle:@"Login"
																  message:@"Need a login view here"
																 delegate:self 
														cancelButtonTitle:NSLocalizedString(@"OK", @"")
														otherButtonTitles:nil];
			parentAlert.tag = LOGINVIEW+ALERT_LOGINPARENT_TAG;
			[parentAlert show];
			[parentAlert release];
			break;
		case 1:
			//push in children's view controller tabs
			NSLog(@"Enter child's melons");
			UIAlertView *childAlert = [[UIAlertView alloc] initWithTitle:@"Login"
																 message:@"Whether need a password for child view? Simply left an hook here."
																delegate:self 
													   cancelButtonTitle:NSLocalizedString(@"OK", @"")
													   otherButtonTitles:nil];
			childAlert.tag = LOGINVIEW+ALERT_LOGINCHILD_TAG;
			[childAlert show];
			[childAlert release];
			break;
			
		default:
			break;
	}
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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

