//
//  GREWord.m
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GREWord.h"


@implementation GREWord
@synthesize strWord;
@synthesize strSentence;
@synthesize strMeaning;
@synthesize strType;
@synthesize iStrength;

-(id) init
{
	self = [super init];
	if(self)
	{
		iStrength = 0;// 1-easy, 2-medium, 3-hard
		strWord = nil;
		strMeaning = nil;
		strSentence = nil;
		strType = nil;
	
		return self;
	}
	return nil;
}

-(id) initWithDictionary:(NSDictionary*)pDictionary
{
	self = [self init];
	if(self)
	{
		strWord = [[NSString alloc] initWithString:[pDictionary objectForKey:ITEM_WORD]];
		strMeaning = [[NSString alloc] initWithString:[pDictionary objectForKey:ITEM_MEANING]];
		strType = [[NSString alloc] initWithString:[pDictionary objectForKey:ITEM_TYPE]];
		strSentence = [[NSString alloc] initWithString:[pDictionary objectForKey:ITEM_SENTENCE]];
		return self;
	}
	return nil;
}

-(void) dealloc
{
	if(strWord)
	{
		[strWord release];
		strWord = nil;
	}
	
	if(strMeaning)
	{
		[strMeaning release];
		strMeaning = nil;
	}
	
	if(strSentence)
	{
		[strSentence release];
		strSentence = nil;
	}
	
	if(strType)
	{
		[strType release];
		strType = nil;
	}
	
	[super dealloc];
}

@end
