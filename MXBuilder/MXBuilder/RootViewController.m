#import "RootViewController.h"
#import "YXPlugin.h"

@interface RootViewController () <UIWebViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWebView];
}

- (NSString *)releaseToPath {
    // 移动www路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *basePath = [documentsDirectory stringByAppendingPathComponent:@"www"];
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"Pandora/www" ofType:@""];
    
    [fileManager removeItemAtPath:basePath error:nil];
    [fileManager copyItemAtPath:resourcePath toPath:basePath error:&error];
    
    return basePath;
}

- (void)initWebView {
    NSString *basePath = [self releaseToPath];
    
    NSString *launch_path = [messageDic objectForKey:@"launch_path"];
    NSString *htmlString = [NSString stringWithContentsOfFile:[basePath stringByAppendingPathComponent:launch_path] encoding:NSUTF8StringEncoding error:NULL];
    
    CGRect webViewFrame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    // 加载www文件
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webViewFrame];
    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:basePath isDirectory:YES]];
    webView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [YXPlugin setWebView:webView rootViewController:self];
    [YXPlugin registPlugin];
}

#pragma mark - UIWebViewDelegate:UIWebView重定向
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end
