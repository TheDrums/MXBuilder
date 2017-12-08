#import "Sprite.h"

@implementation Sprite
@synthesize param2;

- (NSString *)eat:(JSValue *)obj {
    NSString *eat = @"来自子类的eat";
    NSLog(@"%@", eat);
    return eat;
}

+ (Sprite *)makeNodeWithParam0:(NSString *)param0 {
    return [[Sprite alloc] initWithParam0:param0 param1:@"param3"];
}

- (instancetype)initWithParam0:(NSString *)param0 param1:(NSString *)param1 {
    if (!self) {
        self = [super init];
    }
    self.param0 = param0;
    self.param1 = param1;
    
    return self;
}

- (NSString *)description {
    return self.param0;
}

@end
