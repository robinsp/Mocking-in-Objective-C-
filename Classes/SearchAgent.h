#import <Foundation/Foundation.h>

@protocol WebService
- (NSArray *) search:(NSString *)searchPhrase;
@end

@interface SearchAgent : NSObject {
	id<WebService> webService;
}

- (id) initWith:(id<WebService>)webService;

- (NSArray *) search:(NSString *)phrase;

- (BOOL) isCached:(NSString *)phrase;

@end
