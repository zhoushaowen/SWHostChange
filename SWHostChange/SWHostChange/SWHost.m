//
//  SWHost.m
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWHost.h"

@interface SWHost ()

@property (nonatomic) NSInteger ID;

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
        self.ID = [aDecoder decodeIntegerForKey:@"ID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeInteger:self.ID forKey:@"ID"];
}



@end
