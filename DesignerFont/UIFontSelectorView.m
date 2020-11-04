//
//  UIFontSelectorView.m
//  DesignerFont
//
//  Created by Han Mingjie on 2020/11/3.
//

#import "UIFontSelectorView.h"

@interface UIFontSelectorView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSMutableArray *availableFontsArray;
    UIPickerView *pickerView;
    UIButton *closeButton;
}

@end

@implementation UIFontSelectorView
@synthesize handler;
@synthesize fromFontName;

-(void)setFromFontName:(NSString *)_fromFontName{
    fromFontName = _fromFontName;
    NSInteger index = -1;
    for (int i = 0;i<availableFontsArray.count;i++){
        if ([fromFontName isEqualToString:[availableFontsArray objectAtIndex:i]]){
            index = i;
            break;
        }
    }
    if (index >= 0){
        [pickerView selectRow:index inComponent:0 animated:YES];
    }
}

-(void)closeView{
    [self removeFromSuperview];
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.92 alpha:1.f];
        availableFontsArray = [[NSMutableArray alloc] init];
        NSArray *familyNames = [UIFont familyNames];
        for(NSString *familyName in familyNames ){
            NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
            for(NSString *fontName in fontNames) {
                [availableFontsArray addObject:fontName];
            }
        }
        
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self addSubview:pickerView];
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        [closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setFrame:CGRectMake(frame.size.width-60.f, 0.f, 60.f, 40.f)];
        [closeButton setTitle:@"X" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self addSubview:closeButton];
    }
    return self;
}


#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return availableFontsArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [availableFontsArray objectAtIndex:row];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *fontName = [availableFontsArray objectAtIndex:row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 40.f)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.text = fontName;
    label.font = [UIFont fontWithName:fontName size:24.f];
    return label;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *fontName = [availableFontsArray objectAtIndex:row];
    if (handler){
        handler(fontName);
    }
    return;
}
@end
