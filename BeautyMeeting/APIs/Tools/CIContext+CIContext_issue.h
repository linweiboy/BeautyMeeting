//
//  CIContext+CIContext_issue.h
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2016/10/25.
//  Copyright © 2016年 rongteng. All rights reserved.
//


//解决的问题请看
//http://stackoverflow.com/questions/39570644/cicontext-initwithoptions-unrecognized-selector-sent-to-instance-0x170400960
#import <CoreImage/CoreImage.h>

@interface CIContext (CIContext_issue)

+ (CIContext *)right_contextWithOptions:(NSDictionary<NSString *, id> *)options;

@end
