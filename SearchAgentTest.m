#import <SenTestingKit/SenTestingKit.h>
#import "OCMock/OCMock.h"
#import "SearchAgent.h"

@interface SearchAgentTest : SenTestCase {
	id mockWS;
	SearchAgent *sut;
}

@end

@implementation SearchAgentTest

- (void) setUp {
	mockWS = [OCMockObject mockForProtocol:@protocol(WebService)];
	sut = [[SearchAgent alloc] initWith:mockWS];
}

- (void) testSearch {
	[[mockWS expect] search:@"SearchPhrase"];
	[sut search:@"SearchPhrase"];
	[mockWS verify];
}

- (void) testSearch_doesNotAskForCachedResults {
	BOOL cached = YES;
	
	// No, no, no, no.
	// NO!
	id partial = [OCMockObject partialMockForObject:sut];
	[[[partial expect] andReturnValue:OCMOCK_VALUE(cached)] isCached:@"SearchPhrase"];
	
	[sut search:@"SearchPhrase"];	
	[mockWS verify];
}

- (void) tearDown {
	[sut release];
}

@end
