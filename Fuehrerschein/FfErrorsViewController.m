//
//  ErrorsViewController.m
//  FuhrerscheinAuto
//
//  Created by ultravox on 03.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FfErrorsViewController.h"


@implementation FfErrorsViewController


#pragma mark -
#pragma mark View lifecycle


@synthesize errorsList;
@synthesize cellError;



- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect fr= [UIScreen mainScreen].bounds    ;
    
    //////////// BAR
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        bar = [[FfBackground alloc] initWithFrame:CGRectMake(0, 0, fr.size.width, 40)];
    } else {
        bar = [[FfBackground alloc] initWithFrame:CGRectMake(0, 0, fr.size.height, 40)];
    }
    
    UIButton* backb = [[UIButton alloc] init];
    [bar addSubview:backb];
    
    [backb setImage:[UIImage imageNamed:@"furlogob"] forState:UIControlStateNormal];
    
    [backb sizeToFit];
    
    [backb addTarget: self 
              action: @selector(back:) 
    forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:bar];
    
    /////////////////////

	    
    
	//NSString *dbName = @"fragenfur.db";
//	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
//	NSMutableArray *dataList;
	//creiamo la lista degli autori
	Data *dataTmp;
       
	//dataTmp = [[Data alloc]  init:defaultDBPath dbname:dbName] ;
	dataTmp = [[Data alloc]  init] ;

    
	errorsList = [dataTmp getErrorsDaDb:self->quiztag andQuid:self->quid];
	//[dataTmp release];
	
	//NSLog(@"error count %d" , [errorsList count]);
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
     NSLog(@"back");
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [errorsList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//static NSString *CellIdentifier = @"CellError";
    
   CellError *cell =  (CellError*) [tableView dequeueReusableCellWithIdentifier:@"ErrorCell"];
    if (cell == nil) {
       // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	   // load the top-level objects from the custom cell
		/*
		UIViewController *tempController = [[UIViewController alloc] initWithNibName:@"CellError" bundle:nil];
		cell = tempController.view;
		//cell = tempController;
		[[cell retain] autorelease];
		[tempController release];
		*/
		
				NSArray *items  = [[NSBundle mainBundle] loadNibNamed:@"CellError" owner:self options: nil];
		
		cell = [items objectAtIndex:0];

		
		
		
		
		
		 Frage *f = [errorsList objectAtIndex:indexPath.row];		
//		UITextView* tv = [cell tv0] ; 
//		[tv setText:f.domanda];
       NSMutableString* dom = [NSMutableString stringWithFormat:@"%@ %@ (%@-Punkte)", f.qid, f.domanda, f.weight];
        
		cell.tv0.text = dom;
		cell.tv1.text =f.Risposte_campo2; 
		cell.tv2.text =f.Risposte_campo3; 
		cell.tv3.text =f.Risposte_campo4;
        
        NSString * imgstr = [NSString stringWithFormat:@"%@.jpg", f.image];
        imgstr = [imgstr stringByReplacingOccurrencesOfString:@"p_1_" withString:@"p1"];
        imgstr = [imgstr stringByReplacingOccurrencesOfString:@"p_2_" withString:@"p2"];
        
        UIImage * image = [UIImage imageNamed:imgstr];
        if(nil!=image) {
            
            
            cell.iv0.image = image;
            
        }
        
        
        if ([f.Furanswer_campo2 isEqualToString:@"1"]) {
            UIImage *imguncheck = [UIImage imageNamed:@"icochecked.png"];
			[cell.btn0 setImage:imguncheck forState:UIControlStateNormal ];
        } else {
            UIImage *imguncheck = [UIImage imageNamed:@"icounchecked.png"];
			[cell.btn0 setImage:imguncheck forState:UIControlStateNormal ];
        }
		
        if ([f.Furanswer_campo3 isEqualToString:@"1"]) {
            UIImage *imguncheck = [UIImage imageNamed:@"icochecked.png"];
			[cell.btn1 setImage:imguncheck forState:UIControlStateNormal ];
        } else {
            UIImage *imguncheck = [UIImage imageNamed:@"icounchecked.png"];
			[cell.btn1 setImage:imguncheck forState:UIControlStateNormal ];
        }
        
        
        
        if ([f.Furanswer_campo4 isEqualToString:@"1"]) {
            UIImage *imguncheck = [UIImage imageNamed:@"icochecked.png"];
			[cell.btn2 setImage:imguncheck forState:UIControlStateNormal ];
        } else {
            UIImage *imguncheck = [UIImage imageNamed:@"icounchecked.png"];
			[cell.btn2 setImage:imguncheck forState:UIControlStateNormal ];
        }
		
        if ([f.Risposte_campo4 isEqualToString:@""]) {
            [cell.btn2 setHidden:YES];
        }
        
	//	NSLog(f.domanda);
		
    }
    // Configure the cell...
	//	Frage *f = [errorsList objectAtIndex:indexPath.row];
	
//	cell.textLabel.text = f.domanda;
	
	
    return cell;
    
  
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
/*    
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        
        
        
        if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)  return YES;
        return NO;
        
    }
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
  //  [super dealloc];
}


@end

