#import <UIKit/UIKit.h>
@class SearchAgent;

@interface SearchAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITextField *searchPhraseField;
	SearchAgent *searchAgent;
	int resultCount;
	NSString *errorString;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITextField *searchPhraseField;
@property (nonatomic, retain) SearchAgent *searchAgent;
@property (nonatomic) int resultCount;
@property (nonatomic, retain) NSString *errorString;

- (IBAction) doSearch;


@end

