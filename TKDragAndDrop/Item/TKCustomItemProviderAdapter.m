//
//  TKCustomTableCellItem.m
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/17.
//

#import "TKCustomItemProviderAdapter.h"

@import MobileCoreServices;
@import UniformTypeIdentifiers;

@implementation TKCustomItemProviderAdapter {
    NSDictionary *_userInfo;
}

-(void)dealloc {
    self->_userInfo = nil;
}

-(id)initWithUserInfo:(NSDictionary *)userInfo {
    self = [super init];
    
    if (self) {
        self->_userInfo = [[NSDictionary alloc] initWithDictionary:userInfo copyItems:YES];
    }
    
    return self;
}

-(NSDictionary *)userInfo {
    return self->_userInfo;
}

#pragma mark - NSItemProviderWriting
+(NSArray<NSString *> *)writableTypeIdentifiersForItemProvider {
    return @[UTTypeData.identifier];
}

-(NSProgress * _Nullable)loadDataWithTypeIdentifier:(NSString * _Nonnull)typeIdentifier forItemProviderCompletionHandler:(void (^ _Nonnull)(NSData * _Nullable, NSError * _Nullable))completionHandler {
    
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:100.0];
    NSError *error = nil;
    
    if ([NSJSONSerialization isValidJSONObject:self->_userInfo] == NO) {
        NSString *reason = [[NSString alloc] initWithFormat:@"%@ Unable to serialize user info.", self.description];
        NSDictionary *errorUserInfo = @{NSDebugDescriptionErrorKey: reason,
                                        NSLocalizedDescriptionKey: reason,
                                        NSLocalizedFailureReasonErrorKey: reason};
        NSError *error = [[NSError alloc] initWithDomain:NSItemProviderErrorDomain code:700 userInfo:errorUserInfo];
        
        completionHandler(nil, error);
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self->_userInfo options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error != nil) {
        completionHandler(nil, error);
        return nil;
    }
    
    progress.completedUnitCount = 100.0;
    
    completionHandler(jsonData, nil);
    return progress;
}

#pragma mark - NSItemProviderReading
+(NSArray<NSString *> *)readableTypeIdentifiersForItemProvider {
    return @[UTTypeData.identifier];
}

+(instancetype _Nullable)objectWithItemProviderData:(NSData * _Nonnull)data typeIdentifier:(NSString * _Nonnull)typeIdentifier error:(NSError *__autoreleasing  _Nullable * _Nullable)outError {
    NSError *error = nil;
    NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error != nil) {
        *outError = error;
        return nil;
    }
    
    return [[TKCustomItemProviderAdapter alloc] initWithUserInfo:userInfo];
}

@end
