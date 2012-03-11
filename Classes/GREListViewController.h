//
//  GREListViewController.h
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GREWordViewController.h"

@interface GREListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
	
	// contains GRE words in tabular form, separated by sections
	UISearchBar *pSearchBar;
	UITableView *pListTableView;
	
	NSMutableArray *pSearchRecords;
	NSMutableArray *pSelectedList;
	
	GREWordViewController *pViewController;
	UIImageView *pImageViewCredits;
	
	BOOL bIsBookmarked;
	
	UIButton *pEditButton;
}

@property (nonatomic) BOOL bIsBookmarked;
@property (nonatomic, retain) IBOutlet UIButton *pEditButton;
@property (nonatomic, retain) IBOutlet UIImageView *pImageViewCredits;

@property (nonatomic, retain) IBOutlet UISearchBar *pSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *pListTableView;

@property (nonatomic, retain) NSMutableArray *pSelectedList;

-(IBAction) menuBtnClicked;
-(IBAction) creditsClicked;
-(IBAction) editBtnClicked;

@end
