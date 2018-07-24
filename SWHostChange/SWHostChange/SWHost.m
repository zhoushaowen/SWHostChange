//
//  SWHost.m
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWHost.h"

@interface SWHost ()

@end

@implementation SWHost

- (instancetype)initWithName:(NSString *)name info:(NSDictionary *)info {
    self = [super init];
    if(self){
        self.name = name;
        self.info = info;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self){
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.info forKey:@"info"];
}

- (BOOL)isEqual:(id)object {
    if(object == nil) return NO;
    if(self == object) return YES;
    if(![object isKindOfClass:[SWHost class]]){
        return NO;
    }
    if(!((SWHost *)object).info) return NO;
    return [self.info isEqualToDictionary:((SWHost *)object).info];
}



@end
