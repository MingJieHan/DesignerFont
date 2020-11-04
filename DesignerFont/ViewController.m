//
//  ViewController.m
//  DesignerFont
//
//  Created by Han Mingjie on 2020/11/3.
//

#define SAVE_FONTCONTENT @"Content"
#define SAVE_FONTNAME_KEY @"Font"
#define SAVE_FONTSIZE_KEY @"Size"
#import "ViewController.h"
#import "UIFontSelectorView.h"
#import "UISizeSelectorView.h"
@interface ViewController ()<UITextViewDelegate>{
    UITextView *previewLabel;
    UIFont *currentFont;
    float currentSize;
    UIButton *fontButton;
    UIButton *sizeButton;
    UIFontSelectorView *selectorFontView;
    UISizeSelectorView *selectorSizeView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    currentSize = [[[NSUserDefaults standardUserDefaults] valueForKey:SAVE_FONTSIZE_KEY] floatValue];
    if (currentSize < 4.f){
        currentSize = 16.f;
    }
    NSString *fontName = [[NSUserDefaults standardUserDefaults] valueForKey:SAVE_FONTNAME_KEY];
    if (nil == fontName){
        fontName = @"PingFangSC-Light";
    }
    currentFont = [UIFont fontWithName:fontName size:currentSize];
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:SAVE_FONTCONTENT];
    if (nil == str){
        str = @"Hello Hans!";
    }
    
    previewLabel = [[UITextView alloc] initWithFrame:CGRectMake(0.f, 100.f, self.view.frame.size.width, 200.f)];
    previewLabel.text = str;
    previewLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    previewLabel.textAlignment = NSTextAlignmentCenter;
    previewLabel.backgroundColor = [UIColor clearColor];
    previewLabel.returnKeyType = UIReturnKeyDone;
    previewLabel.delegate = self;
    previewLabel.font = currentFont;
    [self.view addSubview:previewLabel];

    
    sizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sizeButton.layer.borderColor = [UIColor blackColor].CGColor;
    sizeButton.layer.borderWidth = 1.f;
    sizeButton.layer.cornerRadius = 8.f;
    [sizeButton setFrame:CGRectMake(30.f, CGRectGetMaxY(previewLabel.frame)+10.f, self.view.frame.size.width-60.f, 40.f)];
    sizeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [sizeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sizeButton addTarget:self action:@selector(sizeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sizeButton];
    
    fontButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fontButton.layer.borderColor = [UIColor blackColor].CGColor;
    fontButton.layer.borderWidth = 1.f;
    fontButton.layer.cornerRadius = 8.f;
    [fontButton setFrame:CGRectMake(30.f, CGRectGetMaxY(previewLabel.frame)+60, self.view.frame.size.width-60, 40.f)];
    fontButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [fontButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fontButton addTarget:self action:@selector(fontButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fontButton];
    
    [self refresh];
}

-(void)refresh{
    [fontButton setTitle:currentFont.fontName forState:UIControlStateNormal];
    [sizeButton setTitle:[NSString stringWithFormat:@"%.0f",currentSize] forState:UIControlStateNormal];
    previewLabel.font = currentFont;
}


#pragma mark - My
-(void)fontButtonAction{
    [previewLabel resignFirstResponder];
    [selectorSizeView removeFromSuperview];
    if (nil == selectorFontView){
        selectorFontView = [[UIFontSelectorView alloc] initWithFrame:CGRectMake(0.f, self.view.frame.size.height, self.view.frame.size.width, 300.f)];
        ViewController * __strong strong_self = self;
        selectorFontView.handler = ^(NSString * _Nonnull fontName) {
            strong_self->currentFont = [UIFont fontWithName:fontName size:self->currentSize];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setValue:fontName forKey:SAVE_FONTNAME_KEY];
            [user synchronize];
            [strong_self refresh];
        };
    }
    [self.view addSubview:selectorFontView];
    selectorFontView.fromFontName = currentFont.fontName;
    [UIView animateWithDuration:0.3 animations:^{
        [self->selectorFontView setFrame:CGRectMake(0.f, self.view.frame.size.height-300.f, self->selectorFontView.frame.size.width, 300.f)];
    }];
    return;
}

-(void)sizeButtonAction{
    [previewLabel resignFirstResponder];
    [selectorFontView removeFromSuperview];
    
    if (nil == selectorSizeView){
        selectorSizeView = [[UISizeSelectorView alloc] initWithFrame:CGRectMake(0.f, self.view.frame.size.height, self.view.frame.size.width, 300.f)];
        ViewController * __strong strong_self = self;
        selectorSizeView.handler = ^(float fontSize) {
            self->currentSize = fontSize;
            strong_self->currentFont = [UIFont fontWithName:strong_self->currentFont.fontName size:strong_self->currentSize];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setValue:[NSNumber numberWithFloat:strong_self->currentSize] forKey:SAVE_FONTSIZE_KEY];
            [user synchronize];
            [strong_self refresh];
        };
    }
    [self.view addSubview:selectorSizeView];
    selectorSizeView.fromSize = currentSize;
    [UIView animateWithDuration:0.3 animations:^{
        [self->selectorSizeView setFrame:CGRectMake(0.f, self.view.frame.size.height-300.f, self->selectorSizeView.frame.size.width, 300.f)];
    }];
    return;
}


#pragma mark - UITextViewDelegate
-(void)textViewDidEndEditing:(UITextView *)textView{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:textView.text forKey:SAVE_FONTCONTENT];
    [user synchronize];
}

@end


