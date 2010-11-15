//
//  ChildrenItemsVC.m
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-15.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import "ChildrenItemsVC.h"
#import	"Constants.h"
#import	"Global.h"

@implementation ChildrenItemsVC


#pragma mark -
#pragma mark Initialization

- (id)init{
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.title = @"Items";
		self.navigationItem.title = @"Items";
		
		EmptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 220, 90)];
		EmptyLabel.numberOfLines = 0;
		EmptyLabel.text = [NSString stringWithFormat:@"You have no item now. Please work for your melon and trade item in the shop."];
		EmptyLabel.backgroundColor = [UIColor clearColor];
		EmptyLabel.font = [UIFont systemFontOfSize:16];
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

- (void)UseItem:(id)sender{
	UIButton *button = sender;
	NSInteger index = [[button titleForState:UIControlEventTouchDragExit] intValue];
	NSLog(@"done item alert at index:%d",index);
	NSMutableArray *ChildItems = [[NSMutableArray alloc] initWithArray:[GlobalChildInfo objectForKey:@"Items"]];
	NSMutableDictionary *UseItem = [ChildItems objectAtIndex:index];
	[UseItem setObject:@"Using" forKey:@"Status"];
	[ChildItems removeObjectAtIndex:index];
	[ChildItems insertObject:UseItem atIndex:index];
	//[defs setObject:GlobalChildInfo forKey:@"ChildInfo"];
	//[defs synchronize];
	[GlobalChildInfo setObject:ChildItems forKey:@"Items"];
	NSLog(@"items:%@",ChildItems);
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark View lifecycle
- (void)SetTitleButtons{
	NSLog(@"set title button");	
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
	[self CheckItemEmpty];	
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[GlobalChildInfo objectForKey:@"Items"] count];
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
		{
			NSDictionary *Item = [[GlobalChildInfo objectForKey:@"Items"] objectAtIndex:indexPath.row];
			cell.textLabel.text = [Item objectForKey:@"ItemName"];
			
			if ([[Item objectForKey:@"Status"] isEqualToString:@"New"]) {
				UIButton *DoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				DoneButton.tag = MELONVIEW+DONEBUTTON_TAG;
				DoneButton.frame = CGRectMake(320.f-100.f, 4.f, 70.f, 35.f);
				[DoneButton setTitle:@"Use" forState:UIControlStateNormal];
				[DoneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
				[DoneButton	setTitle:[NSString stringWithFormat:@"%d", indexPath.row] forState:UIControlEventTouchDragExit];
				[DoneButton addTarget:self action:@selector(UseItem:) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:DoneButton];			
			}else if ([[Item objectForKey:@"Status"] isEqualToString:@"Using"]) {
				UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(320.f-100.f, 4.f, 70.f, 35.f)];
				label.text = @"Using...";
				[cell.contentView addSubview:label];			
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
    [super dealloc];
}


@end

