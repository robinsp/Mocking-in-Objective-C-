#import "SearchAgent.h"


@implementation SearchAgent


- (id) initWith:(id<WebService>)ws {
	if ((self = [super init]) != nil) {
		webService = ws;
	}
	return self;
}

- (NSArray *) search:(NSString *)phrase {
	if (![self isCached:phrase]) {
		return [webService search:phrase];
	}
	else {
		return [NSArray array];
	}	
}

- (BOOL) isCached:(NSString *)phrase {
	return NO;
}

@end
