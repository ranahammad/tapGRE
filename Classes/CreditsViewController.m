//
//  CreditsViewController.m
//  GRE
//
//  Created by Rana Hammad Hussain on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreditsViewController.h"

@implementation CreditsViewController

-(IBAction) backBtnClicked
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) creativeBugsClicked
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.creativebugs.net"]];
}

-(IBAction) azoshClicked
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.azosh.net"]];
}

-(IBAction) feedbackClicked
{
	NSString *stringURL = @"mailto:feedback@creativebugs.net";
	NSURL *url = [NSURL URLWithString:stringURL];
	[[UIApplication sharedApplication] openURL:url];	
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


- (void)dealloc {
    [super dealloc];
}


@end
