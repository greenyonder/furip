//
//  Frage.h
//  FuhrerscheinAuto
//
//  Created by User on 1/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Frage : NSObject {

	NSString *idkat;
	NSString *qid;
	NSString *domanda;
	NSString *header;
	NSString *image;
	NSString *Risposte_campo2;
	NSString *Risposte_campo3;
	NSString *Risposte_campo4;
	NSString *Furanswer_campo2;
	NSString *Furanswer_campo3;
	NSString *Furanswer_campo4;
	NSString *weight;

	NSString *answer2;
	NSString *answer3;
	NSString *answer4;
	NSString *nfrage;
	NSString *quid;
    
}


@property(nonatomic,retain) NSString *idkat;
@property(nonatomic,retain) NSString *qid;
@property(nonatomic,retain) NSString *domanda;
@property(nonatomic,retain) NSString *header;
@property(nonatomic,retain) NSString *image;
@property(nonatomic,retain) NSString *Risposte_campo2;
@property(nonatomic,retain) NSString *Risposte_campo3;
@property(nonatomic,retain) NSString *Risposte_campo4;
@property(nonatomic,retain) NSString *Furanswer_campo2;
@property(nonatomic,retain) NSString *Furanswer_campo3;
@property(nonatomic,retain) NSString *Furanswer_campo4;
@property(nonatomic,retain) NSString *weight;

@property(nonatomic,retain) NSString *nfrage;
@property(nonatomic,retain) NSString *quid;

@property(nonatomic,retain) NSString *answer2;
@property(nonatomic,retain) NSString *answer3;
@property(nonatomic,retain) NSString *answer4;



@end
