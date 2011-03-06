#import <UIKit/UIKit.h>
@class SearchAgent;

@interface SearchAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITextField *searchPhraseField;
	SearchAgent *searchAgent;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITextField *searchPhraseField;
@property (nonatomic, retain) SearchAgent *searchAgent;

- (IBAction) doSearch;


@end

