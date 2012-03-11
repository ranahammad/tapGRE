//
//  GREWord.h
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ITEM_WORD		@"Word"
#define ITEM_MEANING	@"Meaning"
#define ITEM_TYPE		@"Type"
#define ITEM_SENTENCE	@"Sentence"

@interface GREWord : NSObject 
{
	int		iStrength;
	
	
	NSString *strWord;
	NSString *strMeaning;
	NSString *strSentence;
	NSString *strType;
}

@property (nonatomic) int iStrength;
@property (nonatomic, retain) NSString *strWord;
@property (nonatomic, retain) NSString *strMeaning;
@property (nonatomic, retain) NSString *strSentence;
@property (nonatomic, retain) NSString *strType;


-(id) initWithDictionary:(NSDictionary*)pDictionary;
@end
