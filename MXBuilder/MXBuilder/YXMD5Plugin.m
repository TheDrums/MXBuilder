#import "YXMD5Plugin.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface YXMD5Plugin ()

@property (strong, nonatomic) JSManagedValue *callback;

@end

@implementation YXMD5Plugin

#pragma mark - YXExport 子线程执行 异步
- (void)callCamera:(JSValue *)obj callback:(JSValue *)callback params:(JSValue *)params // JS函数(callback)必须用JSValue
{
    NSString *param = [obj toString];
    [self encryptWithText:param];
    // owner即JSValue在native代码中依托的对象，虚拟机就是通过owner来确认native中的对象图关系
    self.callback = [JSManagedValue managedValueWithValue:callback andOwner:self];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [self.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

// 同步方法
- (NSString *)callMD5:(JSValue *)obj {
    NSString *param = [obj toString];
    return [self md5EncryptUpper:param];
}

- (void)encryptWithText:(NSString *)text {
    JSValue *Callback = [[self.callback value] callWithArguments:@[[self md5EncryptUpper:text]]];
    NSLog(@"%@", [Callback toString]);
}

- (NSString *)md5EncryptUpper:(NSString *)text {
    
    if (self == NULL) {
        return NULL;
    }
    const char *cStr = [text UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
