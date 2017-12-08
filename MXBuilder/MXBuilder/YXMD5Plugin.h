#import "YXPlugin.h"

@protocol YXExportDelegate <JSExport>

JSExportAs (callCamera, - (void)callCamera:(JSValue *)obj callback:(JSValue *)callback params:(JSValue *)params);

- (NSString *)callMD5:(JSValue *)obj;
@end

@interface YXMD5Plugin : YXPlugin <YXExportDelegate>

@end
