//
//  QuizViewController.m
//  GRE
//
//  Created by Rana Hammad Hussain on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuizViewController.h"


@implementation QuizViewController
@synthesize pResultView;
@synthesize pRightCount;
@synthesize pWrongCount;
@synthesize btnRight;
@synthesize btnWrong;
@synthesize btnTap;
@synthesize lblTime;
@synthesize lblWord;
@synthesize lblType;
@synthesize lblMeaning;

-(IBAction) exitBtnClicked
{
	[self dismissModalViewControllerAnimated:YES];
}

-(void) updateScores
{
	[pWrongCount setText:[NSString stringWithFormat:@"%d",iWrongCount]];
	[pRightCount setText:[NSString stringWithFormat:@"%d",iRightCount]];
}

-(void) quizFinished
{
	if(pTimer)
		[pTimer invalidate];
	
	[self.view bringSubviewToFront:pResultView];
	//	UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"Exiting Quiz Mode" message:@"Are you sure?"
	//													delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
	//	[pAlert show];
	//	[pAlert release];	
}

-(void) showMeaning
{
	[lblMeaning setText:[pCurrentWord strMeaning]];
	[btnRight setEnabled:TRUE];
	[btnRight setHidden:FALSE];
	[btnWrong setEnabled:TRUE];
	[btnWrong setHidden:FALSE];
	[btnTap setEnabled:FALSE];
}

-(void) showWord
{
	[lblWord setText:[pCurrentWord strWord]];
	[lblType setText:[pCurrentWord strType]];
	[lblMeaning setText:@"Tap to display meaning"];
	[btnRight setEnabled:FALSE];
	[btnRight setHidden:TRUE];
	[btnWrong setEnabled:FALSE];
	[btnWrong setHidden:TRUE];
	[btnTap setEnabled:TRUE];
}

-(IBAction) quitBtnClicked
{
	[self quizFinished];
}

-(IBAction) retakeBtnClicked
{
	[self.view sendSubviewToBack:pResultView];
	[self startQuiz];
}

-(IBAction) newBtnClicked
{
	[self.view sendSubviewToBack:pResultView];
	
	[pQuizArray removeAllObjects];
	[pQuizArray release];
	
	pQuizArray = [[pDelegate pWordsMgr] loadRandomWords:60];
	
	int j=0;
	for( j=0; j<[[pDelegate pHardList] count]; j++)
	{
		[pQuizArray insertObject:[[pDelegate pHardList] objectAtIndex:j]
						 atIndex:(arc4random()%[pQuizArray count])];
	}
	
	for( j=0; j<[[pDelegate pMediumList] count]; j++)
	{
		[pQuizArray insertObject:[[pDelegate pMediumList] objectAtIndex:j]
						 atIndex:(arc4random()%[pQuizArray count])];
	}
	
	for( j=0; j<[[pDelegate pEasyList] count]; j++)
	{
		[pQuizArray insertObject:[[pDelegate pEasyList] objectAtIndex:j]
						 atIndex:(arc4random()%[pQuizArray count])];
	}
	
	[self startQuiz];
}

-(IBAction) tapBtnClicked
{
	[self showMeaning];
}

-(IBAction) rightBtnClicked
{
	iRightCount++;
	[self updateScores];
	
	iCurrentIndex++;
	pCurrentWord = [pQuizArray objectAtIndex:iCurrentIndex];
	[self showWord];
}

-(IBAction) wrongBtnClicked
{
	iWrongCount++;
	[self updateScores];
	
	iCurrentIndex++;
	pCurrentWord = [pQuizArray objectAtIndex:iCurrentIndex];
	[self showWord];	
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

-(void) updateTimer
{
	if(iTimeCount == 0)
	{
		[self quizFinished];
	}
	else 
	{		
		iTimeCount--;
		if(iTimeCount>9)
			[lblTime setText:[NSString stringWithFormat:@"00:%d",iTimeCount]];
		else
			[lblTime setText:[NSString stringWithFormat:@"00:0%d",iTimeCount]];
	}
}

-(void) startQuiz
{	
	iCurrentIndex = 0;
	pCurrentWord = [pQuizArray objectAtIndex:iCurrentIndex];
	
	iTimeCount = 60;
	iRightCount = 0;
	iWrongCount = 0;
	[self updateScores];
	[lblTime setText:@"01:00"];
	
	[self showWord];
	pTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
											  target:self 
											selector:@selector(updateTimer) 
											userInfo:nil
											 repeats:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	//pQuizArray = [[NSMutableArray alloc] init];
	
	pDelegate = (TapGREAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[self.view addSubview:pResultView];
	[pResultView setCenter:[self.view center]];
	[self newBtnClicked];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft);
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

- (void)dealloc 
{
	[pQuizArray removeAllObjects];
	[pQuizArray release];
	pQuizArray = nil;
    [super dealloc];
}


@end
