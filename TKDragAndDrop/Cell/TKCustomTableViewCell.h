//
//  TKCustomTableViewCell.h
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKCustomTableViewCell : UITableViewCell
@property (class, nonnull, strong, readonly) NSString *identifier;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier;
-(void)setTitle:(NSString * _Nonnull)title;
-(void)setSubTitle:(NSString * _Nonnull)subTitle;
-(void)setTitleImage:(UIImage * _Nonnull)titleImage;
-(NSDictionary * _Nonnull)userInfo;

@end

NS_ASSUME_NONNULL_END
