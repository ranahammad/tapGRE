//
//  TapGREViewController.h
//  TapGRE
//
//  Created by Rana Hammad Hussain on 2/5/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapGREViewController : UIViewController
{
	
	UIImageView *pImageViewCredits;
}

@property (nonatomic, retain) IBOutlet UIImageView *pImageViewCredits;
-(IBAction) wordlistClicked;
-(IBAction) markedlistClicked;
-(IBAction) wordquizClicked;
-(IBAction) optionsClicked;
-(IBAction) creditsClicked;

@end

