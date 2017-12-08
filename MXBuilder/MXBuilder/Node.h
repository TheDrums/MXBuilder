#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NodeDelegate <JSExport>

@property(nonatomic, copy) NSString *param0;
@property(nonatomic, copy) NSString *param1;

- (NSString *)drink;

@end

@interface Node : NSObject<NodeDelegate>

@end
