//
//  QuizViewController.h
//  GRE
//
//  Created by Rana Hammad Hussain on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapGREAppDelegate.h"
#import "GREWord.h"

@interface QuizViewController : UIViewController 
{
	GREWord *pCurrentWord;
	TapGREAppDelegate *pDelegate;
	NSMutableArray *pQuizArray;
	int iCurrentIndex;
	
	UIView *pResultView;
	UILabel *pRightCount;
	UILabel *pWrongCount;
	
	UILabel *lblTime;
	UILabel *lblWord;
	UILabel *lblType;
	UILabel *lblMeaning;
	UIButton *btnRight;
	UIButton *btnWrong;
	UIButton *btnTap;
	
	NSTimer *pTimer;
	int iTimeCount;
	int iRightCount;
	int iWrongCount;
}

@property (nonatomic, retain) IBOutlet UIView *pResultView;
@property (nonatomic, retain) IBOutlet UILabel *pRightCount;
@property (nonatomic, retain) IBOutlet UILabel *pWrongCount;

@property (nonatomic, retain) IBOutlet UILabel *lblTime;
@property (nonatomic, retain) IBOutlet UILabel *lblWord;
@property (nonatomic, retain) IBOutlet UILabel *lblType;
@property (nonatomic, retain) IBOutlet UILabel *lblMeaning;
@property (nonatomic, retain) IBOutlet UIButton *btnRight;
@property (nonatomic, retain) IBOutlet UIButton *btnWrong;
@property (nonatomic, retain) IBOutlet UIButton *btnTap;

-(void) startQuiz;
-(IBAction) quitBtnClicked;
-(IBAction) tapBtnClicked;
-(IBAction) rightBtnClicked;
-(IBAction) wrongBtnClicked;

-(IBAction) retakeBtnClicked;
-(IBAction) newBtnClicked;
-(IBAction) exitBtnClicked;


@end
