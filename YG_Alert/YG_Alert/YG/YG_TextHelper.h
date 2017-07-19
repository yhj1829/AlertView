//
//  YG_TextHelper.h
//  YG_Alert
//
//  Created by yhj on 2017/7/19.
//  Copyright © 2017年 VG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YG_TextHelper : NSObject

+ (NSMutableAttributedString *)attributedString:(NSString *)str lineSpacing:(CGFloat)lineSpacing;

@end
