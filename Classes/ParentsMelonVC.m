//
//  ParentsMelonVC.m
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-6.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import "ParentsMelonVC.h"
#import	"DaddysDollarAppDelegate.h"
#import	"Global.h"
#import	"Constants.h"
#import	"GiveMelonVC.h"
#import	"GiveItemVC.h"


@implementation ParentsMelonVC


#pragma mark -
#pragma mark Initialization

- (id)init{
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.title = @"Melons";
		self.navigationItem.title = [GlobalChildInfo objectForKey:@"Name"];
		
		//[TTStyleSheet setGlobalStyleSheet:[[[TTDefaultStyleSheet alloc] init] autorelease]];
		EmptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 220, 40)];
		EmptyLabel.text = [NSString stringWithFormat:@"%@ has no item", [GlobalChildInfo objectForKey:@"Name"]];
		EmptyLabel.backgroundColor = [UIColor clearColor];
		EmptyLabel.font = [UIFont systemFontOfSize:20];
		EmptyLabel.textAlignment = UITextAlignmentCenter;
		EmptyLabel.hidden = YES;
		EmptyLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
		EmptyLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		EmptyLabel.textColor = [UIColor darkGrayColor];
		[self.tableView addSubview:EmptyLabel];
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

#pragma mark Melon View Handle
- (void)CheckItemEmpty{
	EmptyLabel.hidden = ([[GlobalChildInfo objectForKey:@"Items"] count] > 0);
}


- (void)presentSheet{
	UIActionSheet *menu;
	menu = [[UIActionSheet alloc] initWithTitle:nil 
									   delegate:self 
							  cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
						 destructiveButtonTitle:nil 
							  otherButtonTitles:NSLocalizedString(@"Give Melon", @""), NSLocalizedString(@"Give Item", @""), nil];
	
	[menu showInView:self.tabBarController.view];
	[menu release];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet 
clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"Give Melon", @"")])) {
		NSLog(@"Give Melon");
		GiveMelonVC *giveMelonVC = [[GiveMelonVC alloc] init];
		UINavigationController *giveMelonNVC = [[UINavigationController alloc] initWithRootViewController:giveMelonVC];
		[self presentModalViewController:giveMelonNVC animated:YES];
	}else if (([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"Give Item", @"")])) {
		NSLog(@"Give Item");
		GiveItemVC *giveItemVC = [[GiveItemVC alloc] init];
		UINavigationController *giveItemNVC = [[UINavigationController alloc] initWithRootViewController:giveItemVC];
		[self presentModalViewController:giveItemNVC animated:YES];
	}else {
		NSLog(@"Cancel");
	}

}

- (void)DoneItem:(NSInteger)index{
	NSMutableArray *ChildItems = [[NSMutableArray alloc] initWithArray:[GlobalChildInfo objectForKey:@"Items"]];
	[ChildItems removeObjectAtIndex:index];
	[GlobalChildInfo setObject:ChildItems forKey:@"Items"];
	//[defs setObject:GlobalChildInfo forKey:@"ChildInfo"];
	//[defs synchronize];
	NSLog(@"Done an item:%@",GlobalChildInfo);
	NSUInteger ii[2] = {1, index};
	NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
	//NSLog(@"remove index:%@",indexPath);
	[self.tableView	deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[self CheckItemEmpty];
	[self.tableView reloadData];
}

- (void)DoneItemAlert:(id)sender{
	UIButton *button = sender;
	NSInteger index = [[button titleForState:UIControlEventTouchDragExit] intValue];
	NSLog(@"done item alert at index:%d",index);
	UIAlertView *ItemAlert = [[UIAlertView alloc] initWithTitle:@"Clear items" message:[NSString stringWithFormat:@"Are you fulfilled your children request on this item:\"%@\"?",[[[GlobalChildInfo objectForKey:@"Items"] objectAtIndex:index] objectForKey:@"ItemName"]]
													   delegate:self 
											  cancelButtonTitle:@"Yes" 
											  otherButtonTitles:@"No",nil];
	ItemAlert.tag = MELONVIEW+ALERT_DONE_TAG;
	DeletedIndex = index;
	[ItemAlert show];
	[ItemAlert release];
}

- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (alertView.tag == (MELONVIEW+ALERT_DONE_TAG)) {
		switch (buttonIndex) {
			case 0:
				[self DoneItem:DeletedIndex];
				break;
			default:
				break;
		}
	}
}

#pragma mark -
#pragma mark View lifecycle
- (void)QuitParentView{
	[self.parentViewController.parentViewController.navigationController popViewControllerAnimated:YES];
}

- (void)SetTitleButtons{
	NSLog(@"set title button");
	
	UIBarButtonItem *left = 
	[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(QuitParentView)];
	self.navigationItem.leftBarButtonItem = left;
	[left release];

	UIBarButtonItem *right = 
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(presentSheet)];
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
    [super viewWillAppear:animated];
	[self SetTitleButtons];
	[self.tableView reloadData];
	[self CheckItemEmpty];
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
	NSString *titleStr;
	switch (section) {
		case 0:
			titleStr = [NSString stringWithFormat:@"%@'s melons",[GlobalChildInfo objectForKey:@"Name"]];
			break;
		case 1:
			titleStr = [NSString stringWithFormat:@"%@'s items",[GlobalChildInfo objectForKey:@"Name"]];
			break;
		case 2:
			titleStr = [NSString stringWithFormat:@"%@ has no items",[GlobalChildInfo objectForKey:@"Name"]];
			break;

		default:
			titleStr = @"";
			break;
	}
	CGSize maxSize = CGSizeMake(320-36, 20);
	CGSize size = [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 320-36, size.height)];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont systemFontOfSize:14];
	titleLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
	titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
	titleLabel.textColor = [UIColor darkGrayColor];
	titleLabel.text = titleStr;
	titleLabel.numberOfLines = 0;
	
	UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 10)];
	[tmpView addSubview:titleLabel];
	[titleLabel release];
	
	return [tmpView autorelease];		
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	CGFloat titleHeight = 0.f;
	switch (section) {
		default:
			titleHeight = 30.f;
			break;
	}
	return titleHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if ([[GlobalChildInfo objectForKey:@"Items"] count]) {
		return 2;
	}
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rowNumber = 0;
    // Return the number of rows in the section.
	switch (section) {
		case 0:
			rowNumber = 1;
			break;
		case 1:
			rowNumber = [[GlobalChildInfo objectForKey:@"Items"] count];
			break;

		default:
			break;
	}
    return rowNumber;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }*/
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    switch (indexPath.section) {
		case 0:
			cell.textLabel.text = @"Melon";
			NSLog(@"Melon num:%@",[GlobalChildInfo objectForKey:@"Melon"]);
			UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(320-160, 0, 120, 40)];
			NumberLabel.text = [NSString stringWithFormat:@"%@",[GlobalChildInfo objectForKey:@"Melon"]];
			NumberLabel.backgroundColor = [UIColor clearColor];
			NumberLabel.font = [UIFont systemFontOfSize:18];
			NumberLabel.textAlignment = UITextAlignmentRight;
			[cell.contentView addSubview:NumberLabel];
			[NumberLabel release];
			break;
		case 1:
		{
			NSDictionary *Item = [[GlobalChildInfo objectForKey:@"Items"] objectAtIndex:indexPath.row];
			cell.textLabel.text = [Item objectForKey:@"ItemName"];
			
			if ([[Item objectForKey:@"Status"] isEqualToString:@"Using"]) {
				UIButton *DoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				//TTButton *DoneButton = [TTButton buttonWithStyle:@"blueToolbarButton:" title:NSLocalizedString(@"Done", @"")];
				DoneButton.tag = MELONVIEW+DONEBUTTON_TAG;
				DoneButton.frame = CGRectMake(320.f-100.f, 4.f, 70.f, 35.f);
				[DoneButton setTitle:@"Using" forState:UIControlStateNormal];
				[DoneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
				[DoneButton	setTitle:[NSString stringWithFormat:@"%d", indexPath.row] forState:UIControlEventTouchDragExit];
				[DoneButton addTarget:self action:@selector(DoneItemAlert:) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:DoneButton];			
			}
		}
			break;
		default:
			break;
	}
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
	[EmptyLabel release];
    [super dealloc];
}


@end

