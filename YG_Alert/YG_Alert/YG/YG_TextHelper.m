//
//  YG_TextHelper.m
//  YG_Alert
//
//  Created by yhj on 2017/7/19.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "YG_TextHelper.h"

@implementation YG_TextHelper

+ (NSMutableAttributedString *)attributedString:(NSString *)str lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,[str length])];
    return attributedString;
}

@end
