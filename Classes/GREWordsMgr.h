//
//  GREWordsMgr.h
//  GRE
//
//  Created by Rana Hammad Hussain on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define A_WORDS	@"A"
#define B_WORDS	@"B"
#define C_WORDS	@"C"
#define D_WORDS	@"D"
#define E_WORDS	@"E"
#define F_WORDS	@"F"
#define G_WORDS	@"G"
#define H_WORDS	@"H"
#define I_WORDS	@"I"
#define J_WORDS	@"J"
#define K_WORDS	@"K"
#define L_WORDS	@"L"
#define M_WORDS	@"M"
#define N_WORDS	@"N"
#define O_WORDS	@"O"
#define P_WORDS	@"P"
#define Q_WORDS	@"Q"
#define R_WORDS	@"R"
#define S_WORDS	@"S"
#define T_WORDS	@"T"
#define U_WORDS	@"U"
#define V_WORDS	@"V"
#define W_WORDS	@"W"
#define X_WORDS	@"X"
#define Y_WORDS	@"Y"
#define Z_WORDS	@"Z"

#define PLIST_INFO	@"TotalWords"
#define PLIST_ALPHABET	@"GREWords_%@"

@interface GREWordsMgr : NSObject 
{

	// this will load GRE words from XML and maintain arrays
	
	// this will also save the settings of all words in preferences
	
//	NSArray* pAlphabets; // size of this array = 26, and 26 strings of A-Z are stored in it
//	NSMutableArray *pWords; //  size of this array = 26 and 26 mutable arrays of words divided by words are stored in it
	NSMutableArray *pAlphabetsInfo;
	
}

//@property (nonatomic, retain) NSArray *pAlphabets;
@property (nonatomic, retain) NSMutableArray *pAlphabetsInfo;
//@property (nonatomic, retain) NSMutableArray *pWords;


-(NSMutableArray*) loadWordsStartingWithString:(NSString*)strWord;
-(BOOL) loadAllWordsInfo;
-(NSMutableArray*) loadRandomWords:(int)iCount;


@end
