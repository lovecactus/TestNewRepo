//
//  ParentsItemsVC.m
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-8.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import "ParentsItemsVC.h"
#import	"AddItemVC.h"
#import	"Global.h"

@implementation ParentsItemsVC


#pragma mark -
#pragma mark Initialization

- (id)init{
	if (self = [super initWithStyle:UITableViewStyleGrouped]){
		self.title = @"Shop";
		self.navigationItem.title = @"Items";

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
#pragma mark Item Handle
- (void)AddItem{
	NSLog(@"Give Melon");
	AddItemVC *addItemVC = [[AddItemVC alloc] init];
	UINavigationController *addItemNVC = [[UINavigationController alloc] initWithRootViewController:addItemVC];
	[self presentModalViewController:addItemNVC animated:YES];
	
}

#pragma mark -
#pragma mark View lifecycle
- (void)SetTitleButtons{
	NSLog(@"set title button");
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *right = 
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddItem)];
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
	[self.tableView reloadData];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString *titleStr = [NSString stringWithFormat:@"Item name"];

	CGSize maxSize = CGSizeMake(320-36, 20);
	CGSize size = [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 45, 320-36, size.height)];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont systemFontOfSize:14];
	titleLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
	titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
	titleLabel.textColor = [UIColor darkGrayColor];
	titleLabel.text = titleStr;
	titleLabel.numberOfLines = 0;
	
	UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 45, 320-36, size.height)];
	priceLabel.backgroundColor = [UIColor clearColor];
	priceLabel.font = [UIFont systemFontOfSize:14];
	priceLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
	priceLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
	priceLabel.textColor = [UIColor darkGrayColor];
	priceLabel.text = @"Price";
	priceLabel.textAlignment = UITextAlignmentRight;
	priceLabel.numberOfLines = 0;

	UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 320-36, 40)];
	hintLabel.backgroundColor = [UIColor clearColor];
	hintLabel.font = [UIFont systemFontOfSize:14];
	hintLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
	hintLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
	hintLabel.textColor = [UIColor darkGrayColor];
	hintLabel.text = @"(Price is the amount that your children can buy this item using his/her melons)";
	hintLabel.textAlignment = UITextAlignmentCenter;
	hintLabel.numberOfLines = 0;
	
	UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 10)];
	[tmpView addSubview:titleLabel];
	[tmpView addSubview:priceLabel];
	[tmpView addSubview:hintLabel];
	[titleLabel release];
	[priceLabel release];
	[hintLabel release];
	
	return [tmpView autorelease];		
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.

	if ([GlobalItems count]) {
		return 1;
	}else {
		return 2;
	}

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSInteger rowNumber = 0;
	switch (section) {
		case 0:
			rowNumber = [GlobalItems count];
			break;
		default:
			break;
	}
    return rowNumber;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	CGFloat titleHeight = 0.f;
	switch (section) {
		default:
			titleHeight = 60.f;
			break;
	}
	return titleHeight;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    switch (indexPath.section) {
		case 0:
			cell.textLabel.text = [[GlobalItems objectAtIndex:indexPath.row] objectForKey:@"ItemName"];				
			UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(320.f-100.f, 4.f, 70.f, 35.f)];
			priceLabel.backgroundColor = [UIColor clearColor];
			priceLabel.font = [UIFont systemFontOfSize:14];
			priceLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.49f];
			priceLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
			priceLabel.textColor = [UIColor darkGrayColor];
			priceLabel.text = [[GlobalItems objectAtIndex:indexPath.row] objectForKey:@"Price"];
			priceLabel.textAlignment = UITextAlignmentRight;
			priceLabel.numberOfLines = 0;
			[cell.contentView addSubview:priceLabel];
			break;
		default:
			break;
	}
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

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
#pragma mark tablview Editing
// Invoked when the user touches Edit.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Updates the appearance of the Edit|Done button as necessary.
    [super setEditing:editing animated:animated];
	//Enable for both table
	[self.tableView setEditing:editing animated:YES];
	
}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {		
		[GlobalItems removeObjectAtIndex:indexPath.row];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView 
		   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return UITableViewCellEditingStyleDelete;
}
#pragma mark -
#pragma mark Row reordering
// Determine whether a given row is eligible for reordering or not. In this app, all rows except the placeholders for
// new content are eligible, so the test is just the index path row against the number of items in the content.
- (BOOL)tableView:(UITableView *)tableView 
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return YES;
}
// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView 
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
	  toIndexPath:(NSIndexPath *)toIndexPath {
	id from = [GlobalItems objectAtIndex:fromIndexPath.row];
	[GlobalItems removeObjectAtIndex:fromIndexPath.row];
	[GlobalItems insertObject:from atIndex:toIndexPath.row];	
	NSLog(@"moveRowAtIndexPath");
}

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

