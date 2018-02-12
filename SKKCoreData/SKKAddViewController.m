//
//  SKKAddViewController.m
//  SKKCoreData
//
//  Created by admin on 19.01.18.
//  Copyright © 2018 admin. All rights reserved.
//  presentNewController dismissViewController

#import "SKKAddViewController.h"
#import "AppDelegate.h"
#import "Person+CoreDataProperties.h"

@interface SKKAddViewController ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UITextField *namePerson;
@property (nonatomic, strong) UITextField *surnamePerson;

@end

@implementation SKKAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSaveButton];
    
    [self createCancelButton];
    
    [self createTextFields];
    
}

- (void)getMainViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Core Data

- (NSManagedObjectContext *)coreDataContext
{
    if (_coreDataContext)
    {
        return _coreDataContext;
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

- (void) saveNewPersonToCoreData
{
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.coreDataContext];
    person.name = self.namePerson.text;
    person.surname = self.surnamePerson.text;
    
    NSError *error = nil;
    if (![person.managedObjectContext save:&error])
    {
        NSLog(@"Save error");
    }
    
}

- (void)saveNewPerson
{
    if ([self.namePerson.text isEqualToString:@""] || [self.surnamePerson.text isEqualToString:@""])
    {
        return;
    }
    
    [self saveNewPersonToCoreData];
    [self getMainViewController];
}

#pragma mark - Create Views

- (void)createSaveButton
{
    //self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - 100, 30, 80, 30)];
    self.saveButton = [UIButton new];
    self.saveButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.saveButton];
    
    NSArray *pinSaveButtonToTopBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[saveButton(30)]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"saveButton" : self.saveButton
                                                                                          }];
    
    NSArray *pinSaveButtonToLeftRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[saveButton]-20-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"saveButton" : self.saveButton}];
    [self.view addConstraints:pinSaveButtonToTopBottom];
    [self.view addConstraints:pinSaveButtonToLeftRight];
    
    [self.saveButton addTarget:self action:@selector(saveNewPerson) forControlEvents:UIControlEventTouchDown];
}

- (void)createCancelButton
{
    //self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 80, 30)];
    self.cancelButton = [UIButton new];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.cancelButton];
    
    NSArray *pinCancelButtonToTopBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[cancelButton(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"cancelButton" : self.cancelButton
                                                                                            }];
    
    NSArray *pinCancelButtonToLeftRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[cancelButton]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"cancelButton" : self.cancelButton}];
    [self.view addConstraints:pinCancelButtonToTopBottom];
    [self.view addConstraints:pinCancelButtonToLeftRight];
    
    [self.cancelButton addTarget:self action:@selector(getMainViewController) forControlEvents:UIControlEventTouchDown];
}

- (void)createTextFields
{
    //self.namePerson = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x - 100, self.view.center.y / 3, 200, 30)];
    self.namePerson = [UITextField new];
    self.namePerson.translatesAutoresizingMaskIntoConstraints = NO;
    self.namePerson.placeholder = @"Set name of person";
    self.namePerson.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.namePerson];
    
    NSArray *pinNamePersonToTopBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[namePerson(30)]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"namePerson" : self.namePerson
                                                                                          }];
    
    NSArray *pinNamePersonToLeftRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[namePerson]-80-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"namePerson" : self.namePerson}];
    [self.view addConstraints:pinNamePersonToTopBottom];
    [self.view addConstraints:pinNamePersonToLeftRight];
    
    //self.surnamePerson = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x - 100, self.view.center.y / 3 + 40, 200, 30)];
    self.surnamePerson = [UITextField new];
    self.surnamePerson.translatesAutoresizingMaskIntoConstraints = NO;
    self.surnamePerson.placeholder = @"Set surname of person";
    self.surnamePerson.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.surnamePerson];
    
    NSArray *pinSurNamePersonToTopBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[namePerson]-30-[surnamePerson(30)]"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:@{@"namePerson" : self.namePerson,
                                                                                             @"surnamePerson" : self.surnamePerson
                                                                                             }];
    
    NSArray *pinSurNamePersonToLeftRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[surnamePerson]-80-|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:@{@"surnamePerson" : self.surnamePerson}];
    [self.view addConstraints:pinSurNamePersonToTopBottom];
    [self.view addConstraints:pinSurNamePersonToLeftRight];
    
}

@end
