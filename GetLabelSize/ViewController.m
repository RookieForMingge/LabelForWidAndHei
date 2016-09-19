//
//  ViewController.m
//  GetLabelSize
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取到所有的字体名称
    NSArray *familyNames = [UIFont familyNames];
    NSLog(@"所有字体名称--%@",familyNames);
    [self setOneLine];
}

- (void)setMultiLine
{
    UILabel *lbl_text = [UILabel new];
    lbl_text.font = [UIFont systemFontOfSize:14];
    lbl_text.text = @"文字在语言学中指书面语的视觉形式，古代把独体字叫做“文”，把合体字叫做“字”，如今联合起来叫做“文字”，文字的基本个体叫做“字”。在日常生活中，“文字”还可以指书面语、语言、文章、字等。视觉符号形式，突破口语的时间和空间限制。例如汉字、拉丁字母。";
    lbl_text.backgroundColor = [UIColor greenColor];
    lbl_text.numberOfLines = 0;//多行显示，计算高度
    lbl_text.textColor = [UIColor lightGrayColor];
    CGSize lblSize = [lbl_text.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    lbl_text.frame = CGRectMake(10, 100, lblSize.width, lblSize.height);
    [self.view addSubview:lbl_text];
}

- (void)setOneLine
{
    UILabel *lbl_text = [[UILabel alloc]init];
    lbl_text.backgroundColor = [UIColor greenColor];
    lbl_text.text = @"我们是一家人";
    // 设置Label的字体 HelveticaNeue  Courier
    UIFont *fnt = [UIFont fontWithName:@"Courier New" size:24.0f];
    lbl_text.font = fnt;
    // 根据字体得到NSString的尺寸
    CGSize size = [lbl_text.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    // 名字的H
    CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    lbl_text.frame = CGRectMake(100,100, nameW,nameH);
    [self.view addSubview:lbl_text];
}

#pragma mark - 根据文字获取Label的实时大小
- (CGRect)getAttributedStringHeight:(NSString*)strDes andSpaceWidth:(CGFloat)fWidth andFont:(UIFont*)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[strDes dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    [attributedString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     font,
                                     NSFontAttributeName,
                                     [UIColor grayColor],
                                     NSForegroundColorAttributeName,nil]
                              range:NSMakeRange(0, attributedString.length)];
    
    UITextView *temp = [[UITextView alloc]initWithFrame:CGRectMake(100.0f, 100.0f, [UIScreen mainScreen].bounds.size.width - fWidth, 1)];
    [temp setBackgroundColor:[UIColor whiteColor]];
    temp.textColor = [UIColor grayColor];
    temp.font = font;
    [temp setEditable:NO];
    [temp setScrollEnabled:NO];
    temp.attributedText = attributedString;
    // 计算 text view 的高度
    CGRect textSize;
    textSize = temp.bounds;
    // 计算 text view 的高度
    CGSize maxSize=CGSizeMake(textSize.size.width,CGFLOAT_MAX);
    CGSize newSize1=[temp sizeThatFits:maxSize];
    textSize.size = newSize1;
    //XNLog(@"%f",temp.contentSize.height);
    return textSize;
}

@end
