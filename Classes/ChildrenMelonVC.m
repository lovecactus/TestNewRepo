    //
//  ChildrenMelonVC.m
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-14.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import "ChildrenMelonVC.h"
#import	"Constants.h"
#import	"Global.h"


@implementation ChildrenMelonVC

- (id)init{
	if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = @"Melons";
		
		UILabel *TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 220, 80)];
		TextLabel.numberOfLines = 0;
		TextLabel.font = [UIFont boldSystemFontOfSize:20];
		TextLabel.text = @"Need some pictures with different melons here";
		[self.view addSubview:TextLabel];
		
		UILabel *MelonLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 220, 220, 60)];
		MelonLabel.font = [UIFont boldSystemFontOfSize:20];
		MelonLabel.text = [NSString stringWithFormat:@"You have %@ melons!", [GlobalChildInfo objectForKey:@"Melon"]];
		MelonLabel.textAlignment = UITextAlignmentCenter;
		[self.view addSubview:MelonLabel];
		
	}
	return self;
}

- (void)QuitView{
	[self.parentViewController.parentViewController.navigationController popViewControllerAnimated:YES];
}

- (void)SetTitleButtons{
	NSLog(@"set title button");
	
	UIBarButtonItem *left = 
	[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(QuitView)];
	self.navigationItem.leftBarButtonItem = left;
	[left release];
	
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self SetTitleButtons];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
