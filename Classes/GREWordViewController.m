//
//  GREWordViewController.m
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GREWordViewController.h"


@implementation GREWordViewController
@synthesize lblTitle;
@synthesize lblType;
@synthesize lblMeaning;
@synthesize lblSentence;
@synthesize pSelectedWordIndex;
@synthesize pSelectedList;
@synthesize pMenuButton;
@synthesize pBackButton;
@synthesize pLeftButton;
@synthesize pRightButton;
@synthesize pEasyButton;
@synthesize pMediumButton;
@synthesize pHardButton;

@synthesize parentView;
@synthesize bIsBookmarked;

-(IBAction) TapClicked
{
	pSelectedWord = [pSelectedList objectAtIndex:pSelectedWordIndex];
	
	[lblMeaning setText:pSelectedWord.strMeaning];
	[lblSentence setText:pSelectedWord.strSentence];
	
	[pMenuButton setHidden:FALSE];
	[pMenuButton setEnabled:TRUE];
	
	[pBackButton setHidden:FALSE];
	[pBackButton setEnabled:TRUE];
	
	[pLeftButton setHidden:FALSE];
	if (pSelectedWordIndex > 0)
		[pLeftButton setEnabled:TRUE];
	
	[pRightButton setHidden:FALSE];
	
	if (pSelectedWordIndex < [pSelectedList count] - 1)
		[pRightButton setEnabled:TRUE];
	
	if(!bIsBookmarked)
	{
		[pEasyButton setHidden:FALSE];
		[pEasyButton setEnabled:TRUE];
		
		[pMediumButton setHidden:FALSE];
		[pMediumButton setEnabled:TRUE];
		
		[pHardButton setHidden:FALSE];
		[pHardButton setEnabled:TRUE];
	}
	else
	{
		// detect whether the word is in any bookmarked list or not
		
		
		
	}
}

-(IBAction) MenuClicked
{
	if(parentView)
	{
		if([parentView respondsToSelector:@selector(menuBtnClicked)])
			[parentView performSelector:@selector(menuBtnClicked)];
	}
	//	[self dismissModalViewControllerAnimated:YES];
	//	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction) BackClicked
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) EasyClicked
{
	[pEasyButton setEnabled:TRUE];
	[pMediumButton setEnabled:TRUE];
	[pHardButton setEnabled:TRUE];
	
	if([pDelegate addWordToEasyList:pSelectedWord])
	{
		[pMediumButton setEnabled:FALSE];
		[pHardButton setEnabled:FALSE];
	}
}

-(IBAction) MediumClicked
{
	[pEasyButton setEnabled:TRUE];
	[pMediumButton setEnabled:TRUE];
	[pHardButton setEnabled:TRUE];
	
	if([pDelegate addWordToMediumList:pSelectedWord])
	{
		[pEasyButton setEnabled:FALSE];
		[pHardButton setEnabled:FALSE];
	}
}

-(IBAction) HardClicked
{
	[pEasyButton setEnabled:TRUE];
	[pMediumButton setEnabled:TRUE];
	[pHardButton setEnabled:TRUE];
	
	if([pDelegate addWordToHardList:pSelectedWord])
	{
		[pEasyButton setEnabled:FALSE];
		[pMediumButton setEnabled:FALSE];
	}
}

-(IBAction) LeftClicked
{
	[pRightButton setEnabled:TRUE];
	if (pSelectedWordIndex > 0)
		pSelectedWordIndex--;
	
	if(pSelectedWordIndex == 0)
	{
		[pLeftButton setEnabled:FALSE];
	}
	[self showWord];
}

-(IBAction) RightClicked
{
	//	NSMutableArray *pWords = [[[pDelegate pWordsMgr] pWords] objectAtIndex:pSelectedAlphabetIndex];
	
	[pLeftButton setEnabled:TRUE];
	
	if (pSelectedWordIndex < [pSelectedList count] - 1)
		pSelectedWordIndex++;
	
	if(pSelectedWordIndex == [pSelectedList count] -1)
	{
		[pRightButton setEnabled:FALSE];
	}
	
	[self showWord];
}

-(void) showWord
{
	//	NSMutableArray *pWords = [[[pDelegate pWordsMgr] pWords] objectAtIndex:pSelectedAlphabetIndex];
	//	pSelectedWord = [pWords objectAtIndex:pSelectedWordIndex];
	
	pSelectedWord = [pSelectedList objectAtIndex:pSelectedWordIndex];
	
	[lblType setText:[NSString stringWithFormat:@"(%@)",pSelectedWord.strType]];
	[lblTitle setText:pSelectedWord.strWord];
	[lblMeaning setText:@""];
	[lblSentence setText:@"Tap to continue"];
	
	[pMenuButton setHidden:TRUE];
	[pMenuButton setEnabled:FALSE];
	
	[pBackButton setHidden:TRUE];
	[pBackButton setEnabled:FALSE];
	
	[pLeftButton setHidden:TRUE];
	[pLeftButton setEnabled:FALSE];
	
	[pRightButton setHidden:TRUE];
	[pRightButton setEnabled:FALSE];
	
	if(!bIsBookmarked)
	{
		[pEasyButton setHidden:TRUE];
		[pEasyButton setEnabled:FALSE];
		
		[pMediumButton setHidden:TRUE];
		[pMediumButton setEnabled:FALSE];
		
		[pHardButton setHidden:TRUE];
		[pHardButton setEnabled:FALSE];
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	pDelegate = (TapGREAppDelegate*)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
	
	if(bIsBookmarked)
	{
		[pEasyButton setHidden:TRUE];
		[pEasyButton setEnabled:FALSE];
		[pMediumButton setHidden:TRUE];
		[pMediumButton setEnabled: FALSE];
		[pHardButton setHidden:TRUE];
		[pHardButton setEnabled: FALSE];
	}
	//	NSMutableArray *pWords = [[[pDelegate pWordsMgr] pWords] objectAtIndex:pSelectedAlphabetIndex];
	
	pSelectedWord = [pSelectedList objectAtIndex:pSelectedWordIndex];
	
	[self showWord];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
