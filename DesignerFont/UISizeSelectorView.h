//
//  UISizeSelectorView.h
//  DesignerFont
//
//  Created by Han Mingjie on 2020/11/3.
//

#import <UIKit/UIKit.h>


typedef void (^UISizeSelectorView_Changed_Handler)(float fontSize);


NS_ASSUME_NONNULL_BEGIN
@interface UISizeSelectorView : UIView
@property (nonatomic) float fromSize;
@property (nonatomic) UISizeSelectorView_Changed_Handler handler;
@end
NS_ASSUME_NONNULL_END
