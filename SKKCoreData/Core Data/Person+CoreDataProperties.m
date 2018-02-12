//
//  Person+CoreDataProperties.m
//  SKKCoreData
//
//  Created by admin on 19.01.18.
//  Copyright © 2018 admin. All rights reserved.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic name;
@dynamic surname;

@end
