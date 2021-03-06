//
//  GiveMelonVC.m
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-7.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import "GiveMelonVC.h"
#import	"Constants.h"
#import	"Global.h"


@implementation GiveMelonVC


#pragma mark -
#pragma mark Initialization

- (id)init{
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.navigationItem.title = @"Give melon";
			
		NSString *hintStr = [NSString stringWithFormat:@"How many melons you want to give?\n (%@ currently has %@ melons)",[GlobalChildInfo objectForKey:@"Name"],[GlobalChildInfo objectForKey:@"Melon"]];
		UILabel *hintLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 10, 260, 100)] autorelease];
		hintLabel.backgroundColor = [UIColor clearColor];
		hintLabel.font = [UIFont systemFontOfSize:20];
		hintLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
		hintLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		hintLabel.textColor = [UIColor darkGrayColor];
		hintLabel.text = hintStr;
		hintLabel.textAlignment = UITextAlignmentCenter;
		hintLabel.numberOfLines = 0;
		[self.tableView addSubview:hintLabel];
		
		UIButton *BGButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		BGButton.frame = CGRectMake(100, 120, 120, 30);
		[self.tableView addSubview:BGButton];
		
		numberField = [[UITextField alloc] initWithFrame:CGRectMake(110, 125, 100, 20)];
		numberField.textAlignment = UITextAlignmentRight;
		numberField.keyboardType = UIKeyboardTypeNumberPad;
		numberField.returnKeyType = UIReturnKeyGo;
		numberField.font = [UIFont boldSystemFontOfSize:20];
		[self.tableView addSubview:numberField];
		
	}
	return self;
}
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/
#pragma mark Give Melon Hanle
- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex {
	//dummy, only hanle 'OK' here.
	switch (alertView.tag) {
		case GIVEMELONVIEW+ALERT_DONE_TAG:
			[self.parentViewController dismissModalViewControllerAnimated:YES];
			break;
		default:
			break;
	}
}

- (void)GiveMelon{
	NSLog(@"Give %d melons to child",[numberField.text intValue]);
	if ([numberField.text intValue] <=0 ) {
		return;
	}
	NSInteger TotalNum = 0;
	TotalNum += [[GlobalChildInfo objectForKey:@"Melon"] intValue];
	TotalNum += [numberField.text intValue];
	
	[GlobalChildInfo setObject:[NSNumber numberWithInt:TotalNum] forKey:@"Melon"];
	//[defs setObject:GlobalChildInfo forKey:@"ChildInfo"];
	//[defs synchronize];
	UIAlertView *giveAlert = [[UIAlertView alloc] initWithTitle:@"Give Melon"
														  message:[NSString stringWithFormat:@"You just gave %d melons to %@",[numberField.text intValue],[GlobalChildInfo objectForKey:@"Name"]]
														 delegate:self 
												cancelButtonTitle:NSLocalizedString(@"OK", @"")
												otherButtonTitles:nil];
	giveAlert.tag = GIVEMELONVIEW+ALERT_DONE_TAG;
	[giveAlert show];
	[giveAlert release];
}

#pragma mark -
#pragma mark View lifecycle
- (void)QuitView{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)SetTitleButtons{
	NSLog(@"set title button");
	
	UIBarButtonItem *left = 
	[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(QuitView)];
	self.navigationItem.leftBarButtonItem = left;
	[left release];
	
	UIBarButtonItem *right = 
	[[UIBarButtonItem alloc] initWithTitle:@"Give" style:UIBarButtonItemStylePlain target:self action:@selector(GiveMelon)];
	self.navigationItem.rightBarButtonItem = right;
	[right release];
		
}


/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
	[self SetTitleButtons];
	[numberField becomeFirstResponder];
    [super viewWillAppear:animated];
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
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
	[numberField release];
    [super dealloc];
}

#pragma mark textField 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"click done");
	[self GiveMelon];
	return YES;
}



@end

