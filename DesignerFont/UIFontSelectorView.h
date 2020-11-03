//
//  UIFontSelectorView.h
//  DesignerFont
//
//  Created by Han Mingjie on 2020/11/3.
//

#import <UIKit/UIKit.h>


typedef void (^UIFontSelectorView_Changed_Handler)(NSString * _Nonnull fontName);

NS_ASSUME_NONNULL_BEGIN
@interface UIFontSelectorView : UIView
@property (nonatomic) NSString *fromFontName;
@property (nonatomic) UIFontSelectorView_Changed_Handler handler;
@end
NS_ASSUME_NONNULL_END


