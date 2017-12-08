#import "YXPlugin.h"
#import "Sprite.h"

static UIWebView *staticWebView;
static UIViewController *staticRootViewController;

@implementation YXPlugin

+ (void)setWebView:(UIWebView *)webView_ rootViewController:(UIViewController *)rootViewController_ {
    staticWebView = webView_;
    staticRootViewController = rootViewController_;
}

+ (void)registPlugin {
    // 获取UIWebView的JSContext对象
    JSContext *context = [staticWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 导出类
    context[@"Sprite"] = [Sprite class];
    // 继承于JSExport协议的方法可以实例方法被导出
    context[@"spri"] = [[Sprite alloc] initWithParam0:@"param0" param1:@"param1"];
    context[@"log"] = ^(NSString *log) {
        NSLog(@"%@", log);
    };
    
    NSDictionary *permission = [messageDic objectForKey:@"permissions"];
    for (NSString *plugin in [permission allKeys]) {
        JSValue *value = context[@"fox"][plugin];
        // 只注册页面JSContext里存在的对象
        if ([value toObject] != nil) {
            Class cls = NSClassFromString([permission valueForKey:plugin]);
            SEL sel = NSSelectorFromString(@"new");
            id subPlugin = [(id)cls performSelector:sel];
            
            // 注册JSContext里的fox.device为YXMD5Plugin的对象
            context[@"fox"][plugin] = subPlugin;
        }
    }
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        [JSContext currentContext].exception = exceptionValue;
        NSLog(@"exception:%@",[exceptionValue toString]);
    };
}

- (UIWebView *)webView {
    return staticWebView;
}

- (UIViewController *)rootViewController {
    return staticRootViewController;
}

@end
