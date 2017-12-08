#import "Node.h"

@implementation Node
@synthesize param0;
@synthesize param1;

- (NSString *)drink {
    NSString *drink = @"来自父类的draink";
    NSLog(@"%@", drink);
    return drink;
}

@end
