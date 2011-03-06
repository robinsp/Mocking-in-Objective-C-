#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "samplecodeAppDelegate.h"
#import "SearchAgent.h"
#import "OCMock/OCMock.h"

@interface ViewCtlTest : SenTestCase {
	samplecodeAppDelegate *sut;
	id mockPhraseField;
	id mockAgent;
}

- (void) actWithSearchPhrase:(NSString *)inputPhrase;
- (void) wireupAndAct;
	
@end


@implementation ViewCtlTest

- (void) setUp {
	sut =  [[samplecodeAppDelegate alloc] init];
	mockPhraseField = [OCMockObject mockForClass:[UITextField class]];
	mockAgent = [OCMockObject mockForClass:[SearchAgent class]];
} 

- (void) testDoSearch_callsAgent {
	[[mockAgent expect] search:@"search string"];	
	
	[self actWithSearchPhrase:@"search string"];
	
	[mockAgent verify];
}

- (void) testDoSearch_WhenPhrase_isEmpty {
	[[[mockPhraseField stub] andReturn:@""] text];
	
	[self wireupAndAct];
	
	[mockAgent verify];
}

#pragma mark helpers

- (void) actWithSearchPhrase:(NSString *)inputPhrase {
	[[[mockPhraseField stub] andReturn:inputPhrase] text];
	[self wireupAndAct];
}

- (void) wireupAndAct {
	sut.searchPhraseField = mockPhraseField;
	sut.searchAgent = mockAgent;	
	[sut doSearch];	
}

- (void) tearDown {
	[sut release];
}


@end
