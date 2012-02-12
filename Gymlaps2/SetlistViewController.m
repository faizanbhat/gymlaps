//
//  SetlistViewController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SetlistViewController.h"
#import "AppDelegate.h"
#import "TimerCell.h"

@implementation SetlistViewController
@synthesize delegate = _delegate, timers = _timers;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.timers = [self fetchTimers];
        self.navigationItem.title = @"Saved Timers";
    }
    
    return self;
}

-(NSArray*)fetchTimers {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Timer" inManagedObjectContext:context]];

    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];

    
    NSError* error = nil;
    NSArray* results = [context executeFetchRequest:request error:&error];
    
    return results;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];

    self.navigationItem.leftBarButtonItem = cancel;
    self.tableView.backgroundColor = [UIColor whiteColor]; /*#cccccc*/
    self.tableView.separatorColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void)cancel {
    
    if ([self.delegate respondsToSelector:@selector(setlistViewControllerDidCancel:)]) {
        
        [self.delegate setlistViewControllerDidCancel:self];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.timers = [self fetchTimers];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.timers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimerCell";
    
    TimerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
       NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TimerCell" owner:self options:nil];
        
        for (id object in topLevelObjects) {
            if ([object isKindOfClass:[UITableViewCell class]]) {
                cell = (TimerCell*)object;
                break;
            }
        }
    }
    
    // Configure the cell...
    Timer *t = [self.timers objectAtIndex:indexPath.row];
    cell.name.text = t.name;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.contentView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    cell.t1mins.text = [TimerCell textForMinutes: t.intervalOneMinutes];
    cell.t2mins.text = [TimerCell textForMinutes: t.intervalTwoMinutes];
    cell.t1secs.text = [TimerCell textForSeconds: t.intervalOneSeconds];
    cell.t2secs.text = [TimerCell textForSeconds: t.intervalTwoSeconds];

    cell.laps.text = [TimerCell textForLaps: t.laps];
    cell.alarmMode.text = [TimerCell textForAlarmMode: t.alarmMode];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56;
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(setlistViewController:didLoadTimer:)]) {
        
        [self.delegate setlistViewController:self didLoadTimer:[self.timers objectAtIndex:indexPath.row]];
    }
}

@end



