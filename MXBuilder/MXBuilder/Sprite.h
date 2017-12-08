#import "Node.h"
@class Sprite;

@protocol SpriteDelegate <JSExport>

JSExportAs (eat, - (NSString *)eat:(JSValue *)obj);

@property(nonatomic, copy) NSString *param2;

- (NSString *)description;

- (instancetype)initWithParam0:(NSString *)param0 param1:(NSString *)param1;

+ (Sprite *)makeNodeWithParam0:(NSString *)param0;

@end
@interface Sprite : Node<SpriteDelegate>

@end
