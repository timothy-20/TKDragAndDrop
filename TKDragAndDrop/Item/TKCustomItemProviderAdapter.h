//
//  TKCustomTableCellItem.h
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKCustomItemProviderAdapter : NSObject <NSItemProviderReading, NSItemProviderWriting>
-(id)initWithUserInfo:(NSDictionary * _Nonnull)userInfo;
-(NSDictionary * _Nonnull)userInfo;

@end

NS_ASSUME_NONNULL_END
