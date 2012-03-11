//
//  TapGREAppDelegate.m
//  TapGRE
//
//  Created by Rana Hammad Hussain on 2/5/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "TapGREAppDelegate.h"
#import "TapGREViewController.h"
#import "GREWord.h"

@implementation TapGREAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize pWordsMgr;
@synthesize pEasyList;
@synthesize pMediumList;
@synthesize pHardList;
@synthesize bShowOnTap;
@synthesize iQuizTimeCount;

#pragma mark -
#pragma mark Application lifecycle

-(BOOL) addWordToEasyList:(GREWord*)pWord
{
	for (int i=0; i<[pEasyList count]; i++)
	{
		GREWord *pEasyWord = [pEasyList objectAtIndex:i];
		if([[pEasyWord strWord] isEqualToString:[pWord strWord]])
		{
			[pEasyList removeObjectAtIndex:i];
			return FALSE;
		}
	}
	[pEasyList addObject:pWord];
	return TRUE;
}

-(BOOL) addWordToMediumList:(GREWord*)pWord
{
	for (int i=0; i<[pMediumList count]; i++)
	{
		GREWord *pMedWord = [pMediumList objectAtIndex:i];
		if([[pMedWord strWord] isEqualToString:[pWord strWord]])
		{
			[pMediumList removeObjectAtIndex:i];
			return FALSE;
		}
	}
	[pMediumList addObject:pWord];
	return TRUE;
}

-(BOOL) addWordToHardList:(GREWord*)pWord
{
	for (int i=0; i<[pHardList count]; i++)
	{
		GREWord *pHardWord = [pHardList objectAtIndex:i];
		if([[pHardWord strWord] isEqualToString:[pWord strWord]])
		{
			[pHardList removeObjectAtIndex:i];
			return FALSE;
		}
	}
	[pHardList addObject:pWord];
	return TRUE;
}

-(void) loadRecords
{
	[pWordsMgr loadAllWordsInfo];
	
	//
	pDBController = [[CSqliteController alloc] init];
	
	if([pDBController connectToDatabase:@"grewords.sqlite"])
	{
		if([pDBController initTable:@"wordsTable"])
		{
			[pDBController addColumnToTable:@"id" dataType:DATA_TYPE_INT];
			[pDBController addColumnToTable:@"level" dataType:DATA_TYPE_INT];
			[pDBController addColumnToTable:@"word" dataType:DATA_TYPE_STRING];
			[pDBController addColumnToTable:@"type" dataType:DATA_TYPE_STRING];
			[pDBController addColumnToTable:@"meaning" dataType:DATA_TYPE_STRING];
			[pDBController addColumnToTable:@"sentence" dataType:DATA_TYPE_STRING];
			
			NSMutableArray *pRecords = [pDBController loadRecordsFromTable];
			
			for(int i=0; i<[pRecords count]; i++)
			{
				NSMutableArray *pRow = [pRecords objectAtIndex:i];
				
				int iLevel = [[pRow objectAtIndex:1] intValue];
				
				GREWord *pWord = [[GREWord alloc] init];
				pWord.strWord = [[NSString alloc] initWithString:[pRow objectAtIndex:2]];
				pWord.strType = [[NSString alloc] initWithString:[pRow objectAtIndex:3]];
				pWord.strMeaning = [[NSString alloc] initWithString:[pRow objectAtIndex:4]];
				pWord.strSentence = [[NSString alloc] initWithString:[pRow objectAtIndex:5]];
				
				if(iLevel == 0) // add to easy list
					[pEasyList addObject:pWord];
				else if(iLevel == 1) // add to medium list
					[pMediumList addObject:pWord];
				else if(iLevel == 2)// add to hard list
					[pHardList addObject:pWord];
				
				[pWord release];
			}
		}
	}
}

-(void) saveRecords
{
	// save easy, medium, hard lists
	// save stats about quiz/practice mode
	
	if(pDBController)
	{
		
		[pDBController deleteAllRecords];
		
		if([pEasyList count]>0)
		{
			for (int i=0; i<[pEasyList count]; i++)
			{
				GREWord *pWord = [pEasyList objectAtIndex:i];
				NSMutableArray *pRecord = [[NSMutableArray alloc] init];
				
				[pRecord addObject:[NSString stringWithFormat:@"0"]];//ID
				[pRecord addObject:[NSString stringWithFormat:@"0"]];//level
				[pRecord addObject:[pWord strWord]];//word
				[pRecord addObject:[pWord strType]];//type
				[pRecord addObject:[pWord strMeaning]];//meaning
				[pRecord addObject:[pWord strSentence]];//sentence
				
				[pDBController addRecordInTable:pRecord isAutoPrimaryKeyEnabled:YES];
				[pRecord release];
			}
		}
		if([pMediumList count]>0)
		{
			for (int i=0; i<[pMediumList count]; i++)
			{
				GREWord *pWord = [pMediumList objectAtIndex:i];
				NSMutableArray *pRecord = [[NSMutableArray alloc] init];
				
				[pRecord addObject:[NSString stringWithFormat:@"0"]];//ID
				[pRecord addObject:[NSString stringWithFormat:@"1"]];//level
				[pRecord addObject:[pWord strWord]];//word
				[pRecord addObject:[pWord strType]];//type
				[pRecord addObject:[pWord strMeaning]];//meaning
				[pRecord addObject:[pWord strSentence]];//sentence
				
				[pDBController addRecordInTable:pRecord isAutoPrimaryKeyEnabled:YES];
				[pRecord release];
			}
		}
		if([pHardList count]>0)
		{
			for (int i=0; i<[pHardList count]; i++)
			{
				GREWord *pWord = [pHardList objectAtIndex:i];
				NSMutableArray *pRecord = [[NSMutableArray alloc] init];
				
				[pRecord addObject:[NSString stringWithFormat:@"0"]];//ID
				[pRecord addObject:[NSString stringWithFormat:@"1"]];//level
				[pRecord addObject:[pWord strWord]];//word
				[pRecord addObject:[pWord strType]];//type
				[pRecord addObject:[pWord strMeaning]];//meaning
				[pRecord addObject:[pWord strSentence]];//sentence
				
				[pDBController addRecordInTable:pRecord isAutoPrimaryKeyEnabled:YES];
				[pRecord release];
			}
		}
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    iQuizTimeCount = 60;
	bShowOnTap = TRUE;
	
	//[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
	
	pWordsMgr = [[GREWordsMgr alloc] init];
	pEasyList = [[NSMutableArray alloc] init];
	pMediumList = [[NSMutableArray alloc] init];
	pHardList = [[NSMutableArray alloc] init];
	
	[self loadRecords];
	
    // Override point for customization after app launch. 
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	[self saveRecords];
	// save all records
	// save stats
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
	if(pWordsMgr)
	{
		[pWordsMgr release];
		pWordsMgr = nil;
	}
	
	if(pDBController)
	{
		[pDBController release];
		pDBController = nil;
	}
	
	[pEasyList release];
	pEasyList = nil;
	
	[pMediumList release];
	pMediumList = nil;
	
	[pHardList release];
	pHardList = nil;
	
    [viewController release];
    [window release];
    [super dealloc];
}

@end
