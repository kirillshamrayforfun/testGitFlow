//
//  ViewController.m
//  SKKCoreData
//
//  Created by admin on 19.01.18.
//  Copyright © 2018 admin. All rights reserved.
//



#import "ViewController.h"
#import "AppDelegate.h"
#import "Person+CoreDataProperties.h"
#import "SKKAddViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *personArray;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addButton;

@end


@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadModel];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createAddButton];
    [self createTableView];
    [self modelObjectsLog];

}

- (void)getAddViewController
{
    SKKAddViewController *addViewController = [[SKKAddViewController alloc] init];
    
    [self presentViewController:addViewController animated:YES completion:nil];
}

#pragma mark - CoreData

- (void)loadModel
{
    self.personArray = nil;
    self.personArray = [self.coreDataContext executeFetchRequest:[Person fetchRequest] error:nil];
}

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

- (void)modelObjectsLog
{
    NSError *error = nil;
    NSArray *result = [self.coreDataContext executeFetchRequest:[Person fetchRequest] error:&error];
    for (Person *person in result)
    {
        NSLog(@"name: %@ surname: %@", person.name, person.surname);
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personInfo"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"personInfo"];
    }
    
    Person *person = self.personArray[indexPath.row];
    if (person)
    {
        cell.textLabel.text = person.name;
        cell.detailTextLabel.text = person.surname;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.personArray.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"Rows before delete object: %lui", (unsigned long)self.personArray.count);
        [self.coreDataContext deleteObject:self.personArray[indexPath.row]];
        
        NSLog(@"Rows before load Model: %lui", (unsigned long)self.personArray.count);
        [self loadModel];
        NSLog(@"Rows after load Model: %lui", (unsigned long)self.personArray.count);

        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Rows afer delete rows: %lui", (unsigned long)self.personArray.count);
        
        NSError *error = nil;
        if ([self.coreDataContext hasChanges] && ![self.coreDataContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        }
    }
}

#pragma mark - Create Views

- (void)createAddButton
{
    self.addButton = [UIButton new];
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    
    NSArray *pinAddButtonToTopBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[addButton(30)]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"addButton" : self.addButton
                                                                                         }];
    
    NSArray *pinAddButtonToLeftRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[addButton]-20-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"addButton" : self.addButton}];
    [self.view addConstraints:pinAddButtonToTopBottom];
    [self.view addConstraints:pinAddButtonToLeftRight];
    
    [self.addButton addTarget:self action:@selector(getAddViewController) forControlEvents:UIControlEventTouchDown];
}

- (void)createTableView
{
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetMaxX(self.view.frame), CGRectGetMaxY(self.view.frame) - 80) style:UITableViewStylePlain];
    self.tableView = [UITableView new];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    NSArray *pinTableViewToTopBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[tableView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:@{@"tableView" : self.tableView}];
    
    NSArray *pinTableViewToLeftRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"tableView" : self.tableView}];
    
    [self.view addConstraints:pinTableViewToTopBottom];
    [self.view addConstraints:pinTableViewToLeftRight];
}

@end
