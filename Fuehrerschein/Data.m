//
//  Data.m
//  FuhrerscheinAuto
//
//  Created by User on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Data.h"
#import "Frage.h"
#import "Util.h"

@implementation Data

static sqlite3 *database=nil;

@synthesize lista;
//@synthesize pathDB;
@synthesize numeroQuiz;


NSString *const dbName=@"fragenfur.db";
NSString *const version=@"v1";

-(id) init {
	
//	self->pathDB=path;
   self->pathLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //self->pathDB=[[NSBundle mainBundle] resourcePath];
	//[self caricaValoriDaDb:pathDB];
	
    self->pathDB=[NSString  stringWithFormat:@"%@/Database/db%@.db" , self->pathLibrary, version];
    
    [self checkAndCopyDB ];
    [self setNumeroQuiz];
    
    //[super init];
	return self;
	
}


-(unsigned) getSize {
	
	return [lista count];
}

-(id) objectAtIndex:(unsigned)theIndex {
	
	return [lista objectAtIndex:theIndex];
}



-(void)setValoriDaDbWithFehler:(NSInteger)fehler QuizId:(NSInteger)quid {
	
	NSMutableArray *listaTemp = [[NSMutableArray alloc] init];
	
	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	

	
	if (resconn == SQLITE_OK) {

		NSMutableString *query = [NSMutableString stringWithString:@"Select idkat,qid,domanda,header,image,Risposte_campo2, Risposte_campo3, Risposte_campo4, Furanswer_campo2,Furanswer_campo3,Furanswer_campo4,weight from fragen  "];
		
		 if (fehler!=1 && fehler !=0) {
		
			 [query appendString:@"where weight='%d' "];
			 query = [NSMutableString stringWithFormat:query, fehler];
			 
		 }
        
         [query appendString:@" order by Risposte_campo2 desc "];
        
       if (fehler==0) {
            
            query = [NSMutableString stringWithFormat:@"select idkat, a.qid, a.domanda, a.header, a.image, a.Risposte_Campo2, a.Risposte_Campo3, a.Risposte_Campo4, a.Furanswer_Campo2, a.Furanswer_Campo3, a.Furanswer_Campo4, a.weight , b.nfrage , b.quid from FRAGEN a inner join pruf b on a.qid=b.qid  where b.quid= '%d' order by nfrage ", quid ];
        }
		
		
			
		const char *sql = [query UTF8String];
		
		sqlite3_stmt *selectstmt;
		
	
		int resprepare = sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL);
        
       // NSLog(@"error while binding %s",sqlite3_errmsg(database));


        
        
	//	NSLog(@" sqlite3_prepare_v2 %d", resprepare);
		//NSLog(@" sqlite3_errmsg %@" , sqlite3_errmsg(database));
		
        if(resprepare == SQLITE_OK) {
		
            
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				Frage *f = [[Frage alloc] init];

				f.idkat = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)
                           ];

                
                f.qid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                
               // NSLog(@"qid %@" , f.qid);
                
				f.domanda = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                
              
				f.header = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				f.image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				f.Risposte_campo2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				f.Risposte_campo3= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)];
               //  NSLog(@"Risposte_campo3");
				f.Risposte_campo4= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 7)];
              //  NSLog(@"Risposte_campo4");
				f.Furanswer_campo2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)];
				f.Furanswer_campo3= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 9)];
				f.Furanswer_campo4= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 10)];
				f.weight= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 11)];
                
                if (fehler==0) {
                 f.nfrage= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 12)];   
                 f.quid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 13)];
                
                    
                }
		//	NSLog(@"Risposte_campo11");
			//NSLog(@"weight %@" , f.weight);
                
				[listaTemp addObject:f];
         //       NSLog(@"Risposte_campo11 add");
		//		[f release];
			}
		
		}
        
       // NSLog(@"end loop");
        
		self.lista = listaTemp;
		//[listaTemp release];
	
	
		sqlite3_close(database);
}

}

-(Bookmark) getBookmark:(NSInteger) quizmode {
	int resconn = sqlite3_open([pathDB UTF8String], &database);

	unsigned pos = 0;
    unsigned quid = 0;
	
	if (resconn == SQLITE_OK) {
		
		//const char *sql = "Select id,qid,domanda,header,image,Risposte_campo2, Risposte_campo3, Risposte_campo4, Furanswer_campo2,Furanswer_capo3,Furanswer_campo4,weight";
		NSString *query = @"Select  quid, bookmark from bookmarks where quizmode=?  ";
		
				
			
			
		const char *sql = [query UTF8String];
		
		sqlite3_stmt *selectstmt;
		
		
		int resprepare = sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL);

        
		//NSLog(@" sqlite3_errmsg %@" , sqlite3_errmsg(database));
		if(resprepare == SQLITE_OK) {
			
		sqlite3_bind_int(selectstmt, 1, quizmode);
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				
				quid =  sqlite3_column_int(selectstmt, 0);
                pos =  sqlite3_column_int(selectstmt, 1);
				
			
			}
			
		}
		
		sqlite3_close(database);
		
	}
    
    Bookmark b;
    b.position=pos;
    b.quid=quid;
		return b;
}


-(NSInteger) getNumeroQuiz {
    return self->numeroQuiz;
}

-(void) setNumeroQuiz {
	int resconn = sqlite3_open([pathDB UTF8String], &database);
    
	
	
	if (resconn == SQLITE_OK) {
		
		//const char *sql = "Select id,qid,domanda,header,image,Risposte_campo2, Risposte_campo3, Risposte_campo4, Furanswer_campo2,Furanswer_capo3,Furanswer_campo4,weight";
		NSString *query = @"Select  count(*) from pruf where nfrage=?  ";
		
        
        
        
		const char *sql = [query UTF8String];
		
		sqlite3_stmt *selectstmt;
		
		
		int resprepare = sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL);
        
        
		//NSLog(@" sqlite3_errmsg %@" , sqlite3_errmsg(database));
		if(resprepare == SQLITE_OK) {
			
            sqlite3_bind_int(selectstmt, 1, 1);
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				
				numeroQuiz =  sqlite3_column_int(selectstmt, 0);
               
				
                
			}
			
		}
		
		sqlite3_close(database);
		
	}
   
}


-(NSMutableArray*)getErrorsDaDb:(NSInteger) quiztag andQuid:(NSInteger)  quid{
	
	NSMutableArray *listaTemp = [[NSMutableArray alloc] init];

	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	
	if (resconn == SQLITE_OK) {

		//NSLog(@" SQLITE_OK %d", SQLITE _OK);
		//const char *sql = "Select id,qid,domanda,header,image,Risposte_campo2, Risposte_campo3, Risposte_campo4, Furanswer_campo2,Furanswer_capo3,Furanswer_campo4,weight";
		NSMutableString *query = [[NSMutableString alloc] initWithString:@"Select b.idkat,b.qid,b.domanda,b.header,b.image,b.Risposte_campo2, b.Risposte_campo3, b.Risposte_campo4, b.Furanswer_campo2,b.Furanswer_campo3,b.Furanswer_campo4, b.weight, correct2,correct3,correct4, a.quid  from errors a inner join fragen b on a.qid=b.qid and ((correct2!=answer2) or (correct3!=answer3) or (correct4!=answer4)) "];
		//NSString *query = @"Select a.answer2, a.answer3, a.answer4  from errors a ";
		
        if (quiztag!=9) { // dumb tag =9 e quid=0se vogio vedere tutti gli errori
            [query appendString:@" and a.mode=? "];
        }
        
        if (quid!=0) {
            [query appendString:@" and a.quid=? "];
        }
       
		
		const char *sql = [query UTF8String];
		
		sqlite3_stmt *selectstmt;
		
		
		int resprepare = sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL);
		//NSLog(@" sqlite3_prepare_v2 %d", resprepare);
		//NSLog(@" sqlite3_errmsg %@" , sqlite3_errmsg(database));
		if(resprepare == SQLITE_OK) {
			//NSLog(@" sqlite3_prepare_v2 %d", SQLITE_OK);
			//NSLog(@" prima di step");
			//int ressql = sqlite3_step(selectstmt);
			//NSLog(@" sqlite3_step %d", ressql);
			//NSLog(@" SQLITE_ROW %d", SQLITE_ROW);
            
            if (quiztag!=9)  sqlite3_bind_int(selectstmt, 1, quiztag);
            if (quid!=0)  sqlite3_bind_int(selectstmt, 2, quid);
            
            
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				//NSLog(@"errore rga1  %@" , [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)]);
				
				Frage *f = [[Frage alloc] init];
				
				f.idkat = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];
				f.qid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				f.domanda = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				f.header = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				f.image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				f.Risposte_campo2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				f.Risposte_campo3= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)];
				f.Risposte_campo4= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 7)];
				f.Furanswer_campo2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)];
				f.Furanswer_campo3= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 9)];
				f.Furanswer_campo4= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 10)];
				f.weight= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 11)];
				
				f.answer2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 12)];
				f.answer3= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 13)];
				f.answer4= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 14)];
                
                f.quid= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 15)];			
				
                
				[listaTemp addObject:f];
			//	[f release];
			}
			
		}
		
		
		sqlite3_close(database);

		return listaTemp;


	}
	
}


-(void)insertError:(Frage *) f 
		   answer2:(NSString *) answer2 
		   answer3:(NSString *) answer3 
		   answer4:(NSString *) answer4 
            mode:(NSInteger) mode
            {
	//NSLog(@"insertError in");
	
	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	

	
	if (resconn == SQLITE_OK) {
	
		NSString * sql = @"Insert into errors (qid, answer2,answer3,answer4,correct2,correct3,correct4, mode, quid, weight) values (?,?,?,?,?,?,?,?,?,?)";
		const char * sqlStatement = [sql UTF8String];
		
		sqlite3_stmt * compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1 , &compiledStatement, NULL) == SQLITE_OK) {
			sqlite3_bind_text(compiledStatement, 1, [f.qid UTF8String], -1 , SQLITE_TRANSIENT);
			sqlite3_bind_int(compiledStatement, 2, [[f Furanswer_campo2] intValue]);
			sqlite3_bind_int(compiledStatement, 3, [[f Furanswer_campo3] intValue]);
			sqlite3_bind_int(compiledStatement, 4, [[f Furanswer_campo4] intValue]);
			
			sqlite3_bind_int(compiledStatement, 5, [answer2 intValue]);
			sqlite3_bind_int(compiledStatement, 6, [answer3 intValue]);
			sqlite3_bind_int(compiledStatement, 7, [answer4 intValue]);
            sqlite3_bind_int(compiledStatement, 8, mode);
            sqlite3_bind_int(compiledStatement, 9,  [[f quid] intValue]);
            sqlite3_bind_text(compiledStatement, 10, [f.weight UTF8String], -1 , SQLITE_TRANSIENT);
            
		} 
		
		
		
        NSLog(@"Error @%" , sqlite3_errmsg(database));
		if (sqlite3_step(compiledStatement) == SQLITE_DONE) {
			
			NSLog(@"DONE");
		} else {
            NSLog(@"Insert failed: %s", sqlite3_errmsg(database));
            
            
        }
        
		sqlite3_finalize(compiledStatement);
		
	
	}
	
	
	sqlite3_close(database);
	 
}

-(void)saveBookmark:(Bookmark) bookmark Quizmode:(NSInteger) quizmode {

	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	
    
	
	if (resconn == SQLITE_OK) {
        
		NSString * sql = @"update  bookmarks set bookmark=? , quid=? where quizmode=? ";
		const char * sqlStatement = [sql UTF8String];
		
		sqlite3_stmt * compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1 , &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_int(compiledStatement, 1, bookmark.position);
            sqlite3_bind_int(compiledStatement, 2, bookmark.quid);
			sqlite3_bind_int(compiledStatement, 3, quizmode);

		} 
		
		if (!sqlite3_step(compiledStatement) == SQLITE_DONE) {
			
			NSLog(@"Error @%" , sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(compiledStatement);
		
        
	}
	
	
	sqlite3_close(database);
	
}

- (BOOL) isPassed:(NSInteger) quid {
    
    
NSMutableString * query = @" select a.weight from fragen a inner join  errors b on a.qid=b.qid where b.quid=? and ((correct2!=answer2) or (correct3!=answer3) or (correct4!=answer4)) ";


    int resconn = sqlite3_open([pathDB UTF8String], &database);
	int sum = 0;
    int punkte5 = 0;
    
	if (resconn == SQLITE_OK) {
    	const char *sql = [query UTF8String];
		
		sqlite3_stmt *selectstmt;
		
		
		int resprepare = sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL);
		//NSLog(@" sqlite3_prepare_v2 %d", resprepare);
		//NSLog(@" sqlite3_errmsg %@" , sqlite3_errmsg(database));
		if(resprepare == SQLITE_OK) {
		
             sqlite3_bind_int(selectstmt, 1, quid);
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
                int punkte = sqlite3_column_int(selectstmt, 0);
                sum += punkte;
                
                if (punkte==5) {
                    punkte5+=punkte;
                }

                
			}
			
		}
		}
		
		sqlite3_close(database);
	


if (sum>10 || punkte5>5) return NO;
else return YES;

}

-(void)resetFehler:(NSString *) filter {
    
	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	  
	
	if (resconn == SQLITE_OK) {
        
		NSString * sql = [NSString stringWithFormat:@"delete  from errors where mode in ( %@ ) ", filter];
		const char * sqlStatement = [sql UTF8String];
		
		sqlite3_stmt * compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1 , &compiledStatement, NULL) == SQLITE_OK) {
			
	//		sqlite3_bind_int(compiledStatement, 1, bookmark.position);
    //        sqlite3_bind_int(compiledStatement, 2, bookmark.quid);
	//		sqlite3_bind_int(compiledStatement, 3, quizmode);
            
		} 
		
		if (!sqlite3_step(compiledStatement) == SQLITE_DONE) {
			
			NSLog(@"Error @%" , sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(compiledStatement);
		
        
	}
	
	
	sqlite3_close(database);
	
}


-(void)checkAndCopyDB
{
    BOOL success;
    
    NSFileManager * fileManager=[NSFileManager defaultManager];
    
    success=[fileManager fileExistsAtPath:pathDB];
   
    // NSLog(@"filedb %@"  , pathDB);
    
    if(success) return; // db gia' aggiornato all'ultima versione
    
    
    // se folder exists db da aggiornare
    // rimuovo folder
    if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/Database" , self->pathLibrary]]) {
        
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/Database" , self->pathLibrary]  error:nil];
    }
    
    // create db directory
    
    [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/Database" , self->pathLibrary] withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString * databasepathfromapp=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    
    //copy db file
    [fileManager copyItemAtPath:databasepathfromapp toPath:pathDB error:nil];
    
}

+(void)finalizeStatements {
	if(database)
		sqlite3_close(database);
}

-(void)dealloc {
	//[lista release];
	//[super dealloc];
}

@end
