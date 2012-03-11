//
//  AlphabetsViewController.h
//  TapGRE
//
//  Created by Rana Hammad Hussain on 2/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapGREAppDelegate.h"

@interface AlphabetsViewController : UIViewController 
{
	UITableView *pTableAlphabets;
	UIImageView *pImageViewCredits;
	
	TapGREAppDelegate *pDelegate;
	
	NSMutableArray *pSelectedList;
}

@property (nonatomic, retain) IBOutlet UIImageView *pImageViewCredits;

@property (nonatomic, retain) IBOutlet UITableView *pTableAlphabets;

-(IBAction) menuBtnClicked;
-(IBAction) creditsClicked;

//-(IBAction) prevBtnClicked;
//-(IBAction) nextBtnClicked;

@end
