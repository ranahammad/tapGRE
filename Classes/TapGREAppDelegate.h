//
//  TapGREAppDelegate.h
//  TapGRE
//
//  Created by Rana Hammad Hussain on 2/5/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GREWord.h"
#import "GREWordsMgr.h"
#import "CSqliteController.h"

@class TapGREViewController;

@interface TapGREAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TapGREViewController *viewController;
	
	GREWordsMgr *pWordsMgr;
	
	NSMutableArray *pEasyList;
	NSMutableArray *pMediumList;
	NSMutableArray *pHardList;
	
	CSqliteController *pDBController;
	
	int		iQuizTimeCount;
	BOOL	bShowOnTap;
}

@property (nonatomic) int iQuizTimeCount;
@property (nonatomic) BOOL bShowOnTap;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TapGREViewController *viewController;
@property (nonatomic, retain) GREWordsMgr *pWordsMgr;

@property (nonatomic, retain) NSMutableArray *pEasyList;
@property (nonatomic, retain) NSMutableArray *pMediumList;
@property (nonatomic, retain) NSMutableArray *pHardList;

-(BOOL) addWordToEasyList:(GREWord*)pWord;
-(BOOL) addWordToMediumList:(GREWord*)pWord;
-(BOOL) addWordToHardList:(GREWord*)pWord;
@end

