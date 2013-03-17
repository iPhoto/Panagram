//
//  LoginConnection.h
//  Login
//  This class is to establish the connection and process
//  data between iOS and web services
//  Created by Lam Lu on 2/24/13.
//  Copyright (c) 2013 Lam Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * create protocol for delegation
 * after create and process the connection and login,
 * the class delegate the job to other classes
 * classes that use this protocol have to implement isLogInSuccessful
 * how does this work? let's say this is class B where we
 * put the protocol ProcessAfterLogin here
 * Class A adopt this protocoll @interface A : NSObject <ProcessAfterLogin>
 * Then class A create an instance of class B and delegate itself to class B
 * [B setDelegate:self]
 * At some point when class B runs into the isLogInSuccessful, it just lets
 * class A to handle the method.
 */

@protocol ProcessAfterLogin <NSObject>

@required
//@param login : Yes = success, No = fail
- (void) isLogInSuccessful : (BOOL)login;

@end

@interface LoginConnection : NSObject

@property (nonatomic, retain) id <ProcessAfterLogin> delegate;
@property (nonatomic,retain) NSMutableData *receivedData;

/*
 * method to create Connection.
 * @param username is the username to login
 * @param password is the password to login
 */
- (void) createConnection : (NSString*)username :(NSString*)password;

/*
 * This function is to parse JSON object get back from php
 * JSON should be in the format {"login"=>"passed"} or
 * {"login":"failed"}
 * @param : data the NSData get back from web services
 * @return: the string parsed or failed if parse error
 */
- (NSString *) parseJSON: (NSData *) data ;
@end
