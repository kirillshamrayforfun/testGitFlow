//
//  Person+CoreDataProperties.h
//  SKKCoreData
//
//  Created by admin on 19.01.18.
//  Copyright © 2018 admin. All rights reserved.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *surname;

@end

NS_ASSUME_NONNULL_END
