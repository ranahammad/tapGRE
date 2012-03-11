//
//  TapGREViewController.m
//  TapGRE
//
//  Created by Rana Hammad Hussain on 2/5/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "TapGREViewController.h"
#import "AlphabetsViewController.h"
#import "CreditsViewController.h"
#import "QuizViewController.h"

@implementation TapGREViewController
@synthesize pImageViewCredits;
-(IBAction) wordlistClicked
{
	// present word list view
	//	GREListViewController *pListController = [[GREListViewController alloc] initWithNibName:@"GREListViewController" 
	//																					 bundle:[NSBundle mainBundle]];
	AlphabetsViewController *pListController = [[AlphabetsViewController alloc] initWithNibName:@"AlphabetsViewController" 
																						 bundle:[NSBundle mainBundle]];
	
	[self presentModalViewController:pListController animated:YES];
	[pListController release];
}

-(IBAction) markedlistClicked
{
	// present marked list view
	
}

-(IBAction) wordquizClicked
{
	// present quiz view
	QuizViewController *pQuizController = [[QuizViewController alloc] initWithNibName:@"QuizViewController" bundle:[NSBundle mainBundle]];
	[self presentModalViewController:pQuizController animated:YES];
	[pQuizController release];
}

-(IBAction) optionsClicked
{
	// present options view
}

-(IBAction) creditsClicked
{
	CreditsViewController *pController = [[CreditsViewController alloc] initWithNibName:@"CreditsViewController" bundle:[NSBundle mainBundle]];
	[self presentModalViewController:pController animated:YES];
	[pController release];
}


- (void) viewDidLoad
{
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
}

//Override to allow orientations other than the default portrait orientation.
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

@end
