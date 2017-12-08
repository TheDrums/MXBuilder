#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface YXPlugin : NSObject

- (UIWebView *)webView;
- (UIViewController *)rootViewController;

+ (void)setWebView:(UIWebView *)webView rootViewController:(UIViewController *)rootViewController;
+ (void)registPlugin;

@end
