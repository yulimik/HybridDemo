//
//  TemplateUtil.m
//  wnd
//
//  Created by wikimo on 15/3/2.
//  Copyright (c) 2015年 jinbi. All rights reserved.
//

#import "TemplateUtil.h"
#import "GRMustache.h"

@implementation TemplateUtil


+ (NSString *)loadHTMLByGRMustache:(NSDictionary *)data :(NSString *)templateName{
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:templateName ofType:@"html"];
    NSString *template = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
    return [GRMustacheTemplate renderObject:data fromString:template error:nil];
}

@end
