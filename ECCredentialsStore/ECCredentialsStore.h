//
//  ECCredentialsStore.h
//
//  Copyright (c) 2013 Eduardo Caselles.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

/**
 `ECCredentialsStore` wraps the main methods to store and retrieve the credentials (username,
 password and tokens) using the system's Keychain on iOS. It relies on the `SSKeychain`
 library to interface with keychain. Thanks to the authors.
 
 `ECCredentialsStore` is implemented as a singleton, so it can be shared through different
 parts of the app.
 */
@interface ECCredentialsStore : NSObject


/**
 Returns the shared instance of the ECCredentialsStore.
 It will create and initialize this shared instance only the first time it is called.
 
 @return A shared instance of the ECCredentialsStore.
 */
+ (instancetype)sharedStore;

#pragma mark - Instance methods

/**
 Stores the credentials in the Keychain.
 The credentials will be stored as a dictionary in the password object of the `SSKeychainQuery`.
 
 @return Returns `YES` on success, or `NO` on failure.
 */
- (BOOL)save;


/**
 Removes the entry related to these credentials from Keychain.
 This method resets the credentials dictionary as well.
 
 @return Returns `YES` on success, or `NO` on failure.
 */
- (BOOL)remove;


#pragma mark - Setters & Getters

/**
 Sets the access token in the credentials dictionary.
 
 @param token A NSString with the access token.
 */
- (void)setAccessToken:(NSString *)token;


/**
 Returns the access token from the credentials dictionary.
 
 @return Returns a NSString containing the access token, or `nil` if there is no access token
 stored.
 */
- (NSString *)accessToken;


/**
 Sets the username in the credentials dictionary.
 
 @param username A NSString with the username.
 */
- (void)setUsername:(NSString *)username;


/**
 Returns the username from the credentials dictionary.
 
 @return Returns a NSString containing the username, or `nil` if there is no username stored.
 */
- (NSString *)username;


/**
 Sets the password in the credentials dictionary.
 
 @param password A NSString with the password.
 */
- (void)setPassword:(NSString *)password;


/**
 Returns the password from the credentials dictionary.
 
 @return Returns a NSString containing the password, or `nil` if there is no password stored.
 */
- (NSString *)password;


/**
 Sets the refresh token in the credentials dictionary.
 
 @param token A NSString with the refresh token.
 */
- (void)setRefreshToken:(NSString *)token;


/**
 Returns the refresh token from the credentials dictionary.
 
 @return Returns a NSString containing the refresh token, or `nil` if there is no refresh
 stored.
 */
- (NSString *)refreshToken;

@end
