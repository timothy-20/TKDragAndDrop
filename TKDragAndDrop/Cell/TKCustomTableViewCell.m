//
//  TKCustomTableViewCell.m
//  TKDragAndDrop
//
//  Created by 임정운 on 2022/10/13.
//

#import "TKCustomTableViewCell.h"

@implementation TKCustomTableViewCell {
    __weak UIView *_viewBackground;
    __weak UIImageView *_imageView;
    __weak UILabel *_labelTitle;
    __weak UILabel *_labelSubTitle;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIView *initialBackground = [[UIView alloc] init];
        initialBackground.backgroundColor = UIColor.clearColor;
        
        UIImageView *initialImageView = [[UIImageView alloc] init];
        initialImageView.contentMode = UIViewContentModeScaleAspectFit;
        initialImageView.backgroundColor = UIColor.clearColor;
        initialImageView.tintColor = UIColor.whiteColor;
        initialImageView.layer.cornerRadius = 5.0f;
        initialImageView.layer.borderColor = UIColor.whiteColor.CGColor;
        initialImageView.layer.borderWidth = 1.0f;
        
        UILabel *initialTitle = [[UILabel alloc] init];
        initialTitle.lineBreakMode = NO;
        initialTitle.numberOfLines = 1;
        initialTitle.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightSemibold];
        initialTitle.textAlignment = NSTextAlignmentLeft;
        initialTitle.textColor = UIColor.whiteColor;
        initialTitle.text = @"";
        
        UILabel *initialSubTitle = [[UILabel alloc] init];
        initialSubTitle.lineBreakMode = NO;
        initialSubTitle.numberOfLines = 1;
        initialSubTitle.font = [UIFont systemFontOfSize:8.0f weight:UIFontWeightRegular];
        initialSubTitle.textAlignment = NSTextAlignmentLeft;
        initialSubTitle.textColor = UIColor.lightGrayColor;
        initialSubTitle.text = @"";
        
        self->_viewBackground = initialBackground;
        self->_imageView = initialImageView;
        self->_labelTitle = initialTitle;
        self->_labelSubTitle = initialSubTitle;
        
        [self->_viewBackground insertSubview:self->_imageView atIndex:0];
        [self->_viewBackground insertSubview:self->_labelTitle atIndex:1];
        [self->_viewBackground insertSubview:self->_labelSubTitle atIndex:2];
        [self.contentView addSubview:self->_viewBackground];
        
        self.backgroundColor = UIColor.clearColor;
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:CGRectInset(frame, frame.size.width * 0.1, frame.size.height * 0.05)];
    
    [self sizingBackgroundViewFrame];
    [self sizingImageViewFrame];
    [self sizingTitleLabelFrame];
    [self sizingSubTitleLabelFrame];
}

-(UIView *)contentView {
    UIView *view = [super contentView];
    view.backgroundColor = UIColor.blackColor;
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.layer.cornerRadius = 5.0f;
    
    return view;
}

-(void)sizingBackgroundViewFrame {
    CGRect superviewFrame = self->_viewBackground.superview.frame;
    CGRect backgroundViewFrame = CGRectMake(0.0f,
                                            0.0f,
                                            superviewFrame.size.width,
                                            superviewFrame.size.height);
    self->_viewBackground.frame = CGRectInset(backgroundViewFrame,
                                              backgroundViewFrame.size.width * 0.03,
                                              backgroundViewFrame.size.height * 0.2);
}

-(void)sizingImageViewFrame {
    CGRect superviewFrame = self->_imageView.superview.frame;
    self->_imageView.frame = CGRectMake(0.0f,
                                        0.0f,
                                        superviewFrame.size.height,
                                        superviewFrame.size.height);
}

-(void)sizingTitleLabelFrame {
    CGRect superviewFrame = self->_labelTitle.superview.frame;
    self->_labelTitle.frame = CGRectMake(superviewFrame.size.height,
                                         0.0f,
                                         superviewFrame.size.width - superviewFrame.size.height,
                                         superviewFrame.size.height * 0.5);
    UIEdgeInsets labelTitleInset = UIEdgeInsetsMake(self->_labelTitle.frame.size.height * 0.05,
                                                    self->_labelTitle.frame.size.width * 0.05,
                                                    self->_labelTitle.frame.size.height * 0.02,
                                                    self->_labelTitle.frame.size.width * 0.03);
    self->_labelTitle.frame = UIEdgeInsetsInsetRect(self->_labelTitle.frame, labelTitleInset);
}

-(void)sizingSubTitleLabelFrame {
    CGRect superviewFrame = self->_labelSubTitle.superview.frame;
    self->_labelSubTitle.frame = CGRectMake(superviewFrame.size.height,
                                            superviewFrame.size.height * 0.5,
                                            superviewFrame.size.width - superviewFrame.size.height,
                                            superviewFrame.size.height * 0.5);
    UIEdgeInsets labelSubTitleInset = UIEdgeInsetsMake(self->_labelSubTitle.frame.size.height * 0.02,
                                                       self->_labelSubTitle.frame.size.width * 0.05,
                                                       self->_labelSubTitle.frame.size.height * 0.05,
                                                       self->_labelSubTitle.frame.size.width * 0.03);
    self->_labelSubTitle.frame = UIEdgeInsetsInsetRect(self->_labelSubTitle.frame, labelSubTitleInset);
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark -
+(NSString *)identifier {
    return @"TKCustomTableViewCell";
}

-(NSDictionary *)userInfo {
    return @{@"title": [NSString stringWithString:self->_labelTitle.text],
             @"subTitle": [NSString stringWithString:self->_labelSubTitle.text]};
}

-(void)setTitle:(NSString *)title {
    if (title != nil) {
        self->_labelTitle.text = title;
    }
}

-(void)setSubTitle:(NSString *)subTitle {
    if (subTitle != nil) {
        self->_labelSubTitle.text = subTitle;
    }
}

-(void)setTitleImage:(UIImage *)titleImage {
    if (titleImage != nil) {
        self->_imageView.image = titleImage;
    }
}

@end
