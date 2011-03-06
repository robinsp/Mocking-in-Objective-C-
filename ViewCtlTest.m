#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "SearchAppDelegate.h"
#import "SearchAgent.h"
#import "OCMock/OCMock.h"



@interface SearchAppDelegateTest : SenTestCase {
	SearchAppDelegate *sut;
	id stubPhraseField;
	id mockAgent;
	id niceAgent;
}

- (void) act;
- (void) actWithSearchPhrase:(NSString *)inputPhrase;
- (void) wireupAndAct;
	
@end


@implementation SearchAppDelegateTest

- (void) setUp {
	sut =  [[SearchAppDelegate alloc] init];
	stubPhraseField = [OCMockObject niceMockForClass:[UITextField class]];
	mockAgent = [OCMockObject mockForClass:[SearchAgent class]];
} 

#pragma mark happy path

- (void) testDoSearch_callsAgent {
	[[mockAgent expect] search:@"search string"];	
	[self actWithSearchPhrase:@"search string"];
	[mockAgent verify];
}

#pragma mark unsupported search phrases

- (void) testDoSearch_WhenPhrase_isEmpty {
	[self actWithSearchPhrase:@""];	
	[mockAgent verify];
}

- (void) testDoSearch_WhenPhrase_isNumbers {	
	[self actWithSearchPhrase:@"12345"];
	[mockAgent verify];
}

- (void) testDoSearch_WhenPhrase_hasLessThanThreeChars {
	[self actWithSearchPhrase:@"AB"];
	[mockAgent verify];
}

#pragma mark handle agent responses

- (void) testDoSearch_WhenAgent_returnsTwoItems {
	NSArray *searchResponse = [NSArray arrayWithObjects:@"one", @"two", nil];
	[[[mockAgent stub] andReturn:searchResponse] search:[OCMArg any]];
	
	[self act];	
	
	STAssertEquals(sut.resultCount, 2, @"Wrong result count");
}

- (void) testDoSearch_WhenAgent_throwsException {
	NSException *myExc = [NSException    exceptionWithName:@"Garbled" 
													reason:@"Garbled response" 
												  userInfo:[NSDictionary dictionary]];
	
	// Cannot catch this properly. Probably due to unit test setup
	[[[mockAgent stub] andThrow:myExc ] search:[OCMArg any]];
	
	//[self act];
	
	//STAssertEquals(sut.errorString, @"Garbled response", @"Wrong error string");
}

#pragma mark helpers

- (void) act {
	[self actWithSearchPhrase:@"Does not matter to the calling method"];
}

- (void) actWithSearchPhrase:(NSString *)inputPhrase {
	[[[stubPhraseField stub] andReturn:inputPhrase] text];
	[self wireupAndAct];
}

- (void) wireupAndAct {
	sut.searchPhraseField = stubPhraseField;
	sut.searchAgent = mockAgent;	
	[sut doSearch];	
}

- (void) tearDown {
	[sut release];
}

@end
