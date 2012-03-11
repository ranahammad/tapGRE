//
//  GREWordsMgr.m
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GREWordsMgr.h"
#import "GREWord.h"

@implementation GREWordsMgr

//@synthesize pWords;
//@synthesize pAlphabets;
@synthesize pAlphabetsInfo;

-(id) init
{
	self = [super init];
	if(self)
	{
//		pWords = [[NSMutableArray alloc] init];
		pAlphabetsInfo = [[NSMutableArray alloc] init];
//		pAlphabets = [[NSArray alloc] initWithObjects:			A_WORDS,	B_WORDS,
//					  C_WORDS,	D_WORDS,	E_WORDS,	F_WORDS,	G_WORDS,	H_WORDS,
//					  I_WORDS,	J_WORDS,	K_WORDS,	L_WORDS,	M_WORDS,	N_WORDS,
//					  O_WORDS,	P_WORDS,	Q_WORDS,	R_WORDS,	S_WORDS,	T_WORDS,
//					  U_WORDS,	V_WORDS,	W_WORDS,	X_WORDS,	Y_WORDS,	Z_WORDS, nil];
		
		return self;
	}
	
	return nil;
}

-(void) dealloc
{
	
	
//	[pWords removeAllObjects];
//	[pWords release];
	
//	[pAlphabets release];
	
	[super dealloc];
}


-(NSMutableArray*) loadWordsStartingWithString:(NSString*)strWord
{
//	int iIndex = [pAlphabets indexOfObject:strWord];
	
	NSMutableArray *pAllWords = [[NSMutableArray alloc] init];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:PLIST_ALPHABET,strWord]
													 ofType:@"plist"];
	
	NSArray *pArray = [[NSArray alloc] initWithContentsOfFile:path];
	
	for (int i=0; i < [pArray count] ; i++)
	{
		GREWord *pWord = [[GREWord alloc] initWithDictionary:[pArray objectAtIndex:i]];
		[pAllWords addObject:pWord];
		[pWord release];
	}
	
	[pArray release];

	return pAllWords;
}

-(NSMutableArray*) loadRandomWords:(int)iCount
{
	NSMutableArray *pRandomWords = [[NSMutableArray alloc] init];

	int iWordCount = iCount/26;
	
	for(int i=0; i<iCount; i++)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:PLIST_ALPHABET,[NSString stringWithFormat:@"%c",65+(i%26)]]
														 ofType:@"plist"];
		
		NSArray *pArray = [NSArray arrayWithContentsOfFile:path];
		
		for (int j=0; j < iWordCount ; j++)
		{
			int iRandIdx = j + (arc4random()%([pArray count] - 1));
			GREWord *pWord = [[GREWord alloc] initWithDictionary:[pArray objectAtIndex:iRandIdx]];
			
			if([pRandomWords count]>0)
				[pRandomWords insertObject:pWord atIndex:arc4random()%[pRandomWords count]];
			else
				[pRandomWords addObject:pWord];
			[pWord release];
		}
	}
	
	return pRandomWords;
}

-(BOOL) loadAllWordsInfo
{
	NSString *path = [[NSBundle mainBundle] pathForResource:PLIST_INFO
													 ofType:@"plist"];
	
	NSArray *pArray = [[NSArray alloc] initWithContentsOfFile:path];
	
	for (int i=0; i < [pArray count] ; i++)
	{
		NSString *str = [[NSString alloc] initWithString:[pArray objectAtIndex:i]];
		[pAlphabetsInfo addObject:str];
		[str release];
	}
	
	[pArray release];
	
	return TRUE;
}

@end
