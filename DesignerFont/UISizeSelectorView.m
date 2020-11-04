//
//  UISizeSelectorView.m
//  DesignerFont
//
//  Created by Han Mingjie on 2020/11/3.
//

#import "UISizeSelectorView.h"

@interface UISizeSelectorView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIPickerView *pickerView;
    UIButton *closeButton;
    NSMutableArray *availableSizesArray;
}

@end

@implementation UISizeSelectorView
@synthesize fromSize;
@synthesize handler;

-(void)setFromSize:(float)_fromSize{
    fromSize = _fromSize;
    NSString *fromString = [NSString stringWithFormat:@"%.0f",fromSize];
    NSInteger index = -1;
    for (int i=0;i<availableSizesArray.count;i++){
        NSString *exist = [availableSizesArray objectAtIndex:i];
        if ([fromString isEqualToString:exist]){
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
        availableSizesArray = [[NSMutableArray alloc] init];
        for (float i=5.f;i<72.f;i++){
            [availableSizesArray addObject:[NSString stringWithFormat:@"%.0f",i]];
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
    return availableSizesArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [availableSizesArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *fontSize = [availableSizesArray objectAtIndex:row];
    if (handler){
        handler([fontSize floatValue]);
    }
    return;
}
@end
