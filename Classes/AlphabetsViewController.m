//
//  AlphabetsViewController.m
//  TapGRE
//
//  Created by Rana Hammad Hussain on 2/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlphabetsViewController.h"
#import "GREListViewController.h"
#import "CreditsViewController.h"


@implementation AlphabetsViewController

@synthesize pTableAlphabets;
@synthesize pImageViewCredits;

#pragma mark Table related methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
{
	return (section==0)?@"Bookmarked Lists":@"Alphabetical Lists";
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return (section==0)?3:26;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *strIdentifier = [NSString stringWithFormat:@"cellIdentifier%d-%d",indexPath.section, indexPath.row];
	
	UITableViewCell *pCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:strIdentifier];
	if(pCell == nil)
	{
		pCell = [[[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:strIdentifier] autorelease];
	}
	
	[pCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	if (indexPath.section == 0) 
	{
		if(indexPath.row == 0)//easy
			[pCell.textLabel setText:[NSString stringWithFormat:@"Easy Words (%d)",[[pDelegate pEasyList] count]]];
		if(indexPath.row == 1)//medium
			[pCell.textLabel setText:[NSString stringWithFormat:@"Medium Words (%d)",[[pDelegate pMediumList] count]]];
		if(indexPath.row == 2)//hard
			[pCell.textLabel setText:[NSString stringWithFormat:@"Hard Words (%d)",[[pDelegate pHardList] count]]];
	}
	else 
	{
		[pCell.textLabel setText:[NSString stringWithFormat:@"%c Words (%@)",65+indexPath.row,
								  [[[pDelegate pWordsMgr] pAlphabetsInfo] objectAtIndex:indexPath.row]]];
	}
	
	[pCell setFrame:CGRectMake(0, 0, 200, 60)];
	[pCell setCenter:CGPointMake(160, 30)];
	return pCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(pSelectedList)
	{
		[pSelectedList removeAllObjects];
		[pSelectedList release];
		pSelectedList = nil;
	}
	
	if(indexPath.section==0)
	{
		// bookmarked words
		GREListViewController *pController = [[GREListViewController alloc] initWithNibName:@"GREListViewController" bundle:[NSBundle mainBundle]];
		[pController setPSelectedList:(indexPath.row==0)?[pDelegate pEasyList]:
		 (indexPath.row?[pDelegate pMediumList]:[pDelegate pHardList])];
		
		if([[pController pSelectedList] count] > 0)
		{
			[pController setBIsBookmarked:TRUE];
			[self presentModalViewController:pController animated:YES];
		}
		[pController release];
		
	}
	else 
	{
		// show selected alphabet words
		if(pSelectedList==nil)
		{
			pSelectedList = [[pDelegate pWordsMgr] loadWordsStartingWithString:
							 [NSString stringWithFormat:@"%c",65+indexPath.row]];
			
			if([pSelectedList count] > 0)
			{
				GREListViewController *pController = [[GREListViewController alloc] initWithNibName:@"GREListViewController" bundle:[NSBundle mainBundle]];
				[pController setPSelectedList:pSelectedList];
				[pController setBIsBookmarked:FALSE];
				[self presentModalViewController:pController animated:YES];
				[pController release];	
			}
		}
	}
	
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

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[pTableAlphabets reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	pDelegate = (TapGREAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	[pTableAlphabets setBackgroundColor:[UIColor clearColor]];
	
	NSArray *pInfoArray = [NSArray arrayWithObjects:
						   [UIImage imageNamed:@"i0000.png"],
						   [UIImage imageNamed:@"i0001.png"],
						   [UIImage imageNamed:@"i0002.png"],
						   [UIImage imageNamed:@"i0003.png"],
						   [UIImage imageNamed:@"i0004.png"],
						   [UIImage imageNamed:@"i0005.png"],
						   [UIImage imageNamed:@"i0006.png"],
						   [UIImage imageNamed:@"i0007.png"],
						   [UIImage imageNamed:@"i0008.png"],
						   [UIImage imageNamed:@"i0009.png"],
						   [UIImage imageNamed:@"i0010.png"],
						   [UIImage imageNamed:@"i0011.png"],
						   [UIImage imageNamed:@"i0012.png"],
						   [UIImage imageNamed:@"i0013.png"],
						   [UIImage imageNamed:@"i0014.png"],
						   [UIImage imageNamed:@"i0015.png"],nil];
	[pImageViewCredits setAnimationImages:pInfoArray];
	[pImageViewCredits setAnimationDuration:1.0];
	[pImageViewCredits setAnimationRepeatCount:0];
	
	[pImageViewCredits startAnimating];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


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

#pragma mark IBAction methods
-(IBAction) menuBtnClicked
{
	[self dismissModalViewControllerAnimated:YES];
}


-(IBAction) creditsClicked
{
	CreditsViewController *pController = [[CreditsViewController alloc] initWithNibName:@"CreditsViewController" bundle:[NSBundle mainBundle]];
	[self presentModalViewController:pController animated:YES];
	[pController release];
}

@end
