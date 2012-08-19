//
//  Data.h
//  FuhrerscheinAuto
//
//  Created by User on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Frage.h"
#import "Util.h"


@interface Data : NSObject {
	NSMutableArray *lista;
	NSString *pathDB;
    NSString *pathLibrary;
    
    NSInteger numeroQuiz;
    
}
@property(nonatomic, retain) NSMutableArray *lista;
//@property(nonatomic, retain) NSString *pathDB;
//@property(nonatomic, retain) NSString *dbName;

@property(nonatomic, assign) NSInteger numeroQuiz;

-(id) init;

-(void) checkAndCopyDB;
-(void) setValoriDaDbWithFehler:(NSInteger)fehler QuizId:(NSInteger)quid;
-(unsigned) getSize;
-(id)objectAtIndex:(unsigned)theIndex;
-(void)setNumeroQuiz;
-(NSInteger)getNumeroQuiz;



-(Bookmark) getBookmark:(NSInteger) quizmode;
-(void) insertError:(Frage *) f answer2:(NSString *) answer2 answer3:(NSString *) answer3 answer4:(NSString *) answer4  mode:(NSInteger) mode;
-(NSMutableArray*)getErrorsDaDb: (NSInteger) quiztag andQuid:(NSInteger) quid ;
-(void)saveBookmark:(Bookmark ) bookmark Quizmode:(NSInteger) quizmode;
-(void)resetFehler:(NSString *) filter;

- (BOOL) isPassed:(NSInteger) quid;



@end
