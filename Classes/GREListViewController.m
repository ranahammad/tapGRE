//
//  GREListViewController.m
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GREListViewController.h"
#import "GREWord.h"
#import "CreditsViewController.h"

@implementation GREListViewController
@synthesize pSearchBar;
@synthesize pListTableView;
@synthesize pImageViewCredits;
@synthesize pSelectedList;
@synthesize bIsBookmarked;
@synthesize pEditButton;

#pragma mark searchbar related methods
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar                    // called when text starts editing

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar                      // return NO to not become first responder
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	//	[searchBar resignFirstResponder];
	
	[pSearchRecords removeAllObjects];
	
	//	NSString *strS = [searchBar text];
	if(searchText && [searchText length] > 0)
	{
		//		NSString *strStart = [NSString stringWithFormat:@"%C",[searchText characterAtIndex:0]];
		
		for(int i=0; i<[pSelectedList count]; i++)
		{
			GREWord *pWord = [pSelectedList objectAtIndex:i];
			
			if([pWord.strWord hasPrefix:[searchText lowercaseString]])
				[pSearchRecords addObject:pWord];
		}
	}
	[pListTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
	[searchBar resignFirstResponder];
}

#pragma mark tableview related methods
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
//{
//	return 1;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
//{
//	if([pSearchRecords count] == 0)
//		return [[[pDelegate pWordsMgr] pAlphabets] objectAtIndex:section];
//	else
//		return [NSString stringWithFormat:@"Searched List"];
//}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	if([pSearchRecords count] == 0)
	{
		return [pSelectedList count];
	}
	
	return [pSearchRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *strIdentifier = @"RowIdentifier";//[NSString stringWithFormat:@"cellIdentifier%d-%d",indexPath.section, indexPath.row];
	
	UITableViewCell *pCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:strIdentifier];
	if(pCell == nil)
	{
		pCell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:strIdentifier] autorelease];
	}
	else
	{
		for(int i=[[pCell subviews] count] - 1; i>=0; i--)
		{
			UIView *pSubView = [[pCell subviews] objectAtIndex:i];
			if([pSubView isKindOfClass:[UILabel class]])
				[pSubView removeFromSuperview];
		}
	}
	[pCell.contentView clearsContextBeforeDrawing];
	
	
	GREWord *pWord;
	if([pSearchRecords count] == 0)
	{
		pWord = [pSelectedList objectAtIndex:indexPath.row];
	}
	else 
	{
		pWord = [pSearchRecords objectAtIndex:indexPath.row];
	}
	
	[pCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	UILabel *pWordLbl = [[UILabel alloc] init];
	[pWordLbl setFrame:CGRectMake(20, 10, 400, 25)];
	[pWordLbl setBackgroundColor:[UIColor clearColor]];
	[pWordLbl setFont:[UIFont boldSystemFontOfSize:20]];
	[pWordLbl setText:[pWord strWord]];
	[pCell addSubview:pWordLbl];
	[pWordLbl release];
	
	UILabel *pLabel = [[UILabel alloc] init];
	[pLabel setFrame:CGRectMake(30, 35, 380, 30)];
	[pLabel setNumberOfLines:2];
	[pLabel setBackgroundColor:[UIColor clearColor]];
	[pLabel setFont:[UIFont italicSystemFontOfSize:14]];
	[pLabel setText:[pWord strMeaning]];
	
	[pCell addSubview:pLabel];
	[pLabel release];
	
	//	UIButton *pTButton = [[UIButton alloc] init];
	//	[pTButton setImage:[UIImage imageNamed:@"red_normal.png"] forState:UIControlStateNormal];
	//	[pTButton setImage:[UIImage imageNamed:@"red_selected.png"] forState:UIControlStateHighlighted];
	//	[pTButton setFrame:CGRectMake(800, 20, 30, 30)];
	//	[pCell addSubview:pTButton];
	//	[pTButton release];
	
	return pCell;
}

- (void)tableView:(UITableView *)tableView	commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(editingStyle == UITableViewCellEditingStyleDelete && bIsBookmarked)
	{
		//		[pListTableView setEditing:TRUE];
		if([pSearchRecords count] == 0)
		{
			[pSelectedList removeObjectAtIndex:indexPath.row];
		}
		else
		{
			GREWord *pWord = [pSearchRecords objectAtIndex:indexPath.row];
			[pSelectedList removeObject:pWord];
			[pSearchRecords removeObjectAtIndex:indexPath.row];
		}
		[pListTableView reloadData];
	}
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	pViewController = [[GREWordViewController alloc] initWithNibName:@"GREWordViewController" 
															  bundle:[NSBundle mainBundle]];
	if([pSearchRecords count] == 0)
	{
		//		pWord = [pSelectedList objectAtIndex:indexPath.row];
		[pViewController setPSelectedList:pSelectedList];
		[pViewController setPSelectedWordIndex:indexPath.row];
	}
	else
	{
		//		pWord = [pSearchRecords objectAtIndex:indexPath.row];
		[pViewController setPSelectedList:pSearchRecords];
		[pViewController setPSelectedWordIndex:indexPath.row];
	}
	
	//	[pViewController setPSelectedList:<#(NSMutableArray *)#>
	//	[pViewController setPSelectedWord:pWord];
	[pViewController setBIsBookmarked:bIsBookmarked];
	[pViewController setParentView:self];
	[self presentModalViewController:pViewController animated:YES];
}

#pragma mark view related methods
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
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
	
	[pSearchBar setFrame:CGRectMake(0, 42, 480, 30)];
	[pListTableView setBackgroundColor:[UIColor clearColor]];
	
	pSearchRecords = [[NSMutableArray alloc] init];
	
	if(bIsBookmarked)
	{
		[pEditButton setHidden:FALSE];
		[pEditButton setEnabled:TRUE];
	}
	else {
		[pEditButton setHidden:TRUE];
		[pEditButton setEnabled:FALSE];
	}
	
}

-(void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if(pViewController)
	{
		[pViewController release];
		pViewController = nil;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    
	[super viewDidUnload];
	
	[pImageViewCredits stopAnimating];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[pSearchRecords removeAllObjects];
	[pSearchRecords release];
	pSearchRecords = nil;
	
    [super dealloc];
}

#pragma mark IBAction methods

-(IBAction) menuBtnClicked
{
	if(pViewController)
	{
		[pViewController dismissModalViewControllerAnimated:NO];
		[pViewController release];
		pViewController = nil;
	}
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) creditsClicked
{
	CreditsViewController *pController = [[CreditsViewController alloc] initWithNibName:@"CreditsViewController" bundle:[NSBundle mainBundle]];
	[self presentModalViewController:pController animated:YES];
	[pController release];
}

-(IBAction) editBtnClicked
{
	if([pListTableView isEditing])
	{
		[pListTableView setEditing:FALSE animated:TRUE];
		[pEditButton setImage:[UIImage imageNamed:@"Edit_button.png"] forState:UIControlStateNormal];
	}
	else
	{
		[pListTableView setEditing:TRUE animated:TRUE];
		[pEditButton setImage:[UIImage imageNamed:@"Done_button.png"] forState:UIControlStateNormal];
	}
	
}

@end
