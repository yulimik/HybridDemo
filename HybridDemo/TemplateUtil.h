//
//  TemplateUtil.h
//  wnd
//
//  Created by wikimo on 15/3/2.
//  Copyright (c) 2015年 jinbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemplateUtil : NSObject

+ (NSString *)loadHTMLByGRMustache:(NSDictionary *)data :(NSString *)templateName;
@end
