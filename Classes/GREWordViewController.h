//
//  GREWordViewController.h
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GREWord.h"
#import "TapGREAppDelegate.h"

@interface GREWordViewController : UIViewController {
	
	UILabel *lblTitle;
	UILabel *lblType;
	UILabel *lblMeaning;
	UILabel *lblSentence;
	
	int pSelectedWordIndex;
	
	GREWord *pSelectedWord;
	TapGREAppDelegate *pDelegate;
	
	UIButton *pMenuButton;
	UIButton *pBackButton;
	UIButton *pLeftButton;
	UIButton *pRightButton;
	UIButton *pEasyButton;
	UIButton *pMediumButton;
	UIButton *pHardButton;
	
	NSMutableArray *pSelectedList;
	
	BOOL bIsBookmarked;
	
	id	parentView;
}

@property (nonatomic) BOOL bIsBookmarked;
@property (nonatomic, retain) id parentView;
//@property (nonatomic, retain) GREWord *pSelectedWord;
@property (nonatomic, retain) NSMutableArray *pSelectedList;
@property (nonatomic) int pSelectedWordIndex;

@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblType;
@property (nonatomic, retain) IBOutlet UILabel *lblMeaning;
@property (nonatomic, retain) IBOutlet UILabel *lblSentence;

@property (nonatomic, retain) IBOutlet UIButton *pMenuButton;
@property (nonatomic, retain) IBOutlet UIButton *pBackButton;
@property (nonatomic, retain) IBOutlet UIButton *pLeftButton;
@property (nonatomic, retain) IBOutlet UIButton *pRightButton;
@property (nonatomic, retain) IBOutlet UIButton *pEasyButton;
@property (nonatomic, retain) IBOutlet UIButton *pMediumButton;
@property (nonatomic, retain) IBOutlet UIButton *pHardButton;

-(void) showWord;


-(IBAction) TapClicked;
-(IBAction) MenuClicked;
-(IBAction) BackClicked;
-(IBAction) EasyClicked;
-(IBAction) MediumClicked;
-(IBAction) HardClicked;
-(IBAction) LeftClicked;
-(IBAction) RightClicked;
@end
