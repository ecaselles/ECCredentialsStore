//
//  ECCredentialsStore.m
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

#import "ECCredentialsStore.h"
#import "ECKeychain.h"

#define kServiceName @"FCService"
#define kAccountName @"FCAccount"

@interface ECCredentialsStore ()

@property (nonatomic, strong) NSMutableDictionary *credentials;

@end

@implementation ECCredentialsStore

#pragma mark - Class methods

+ (instancetype)sharedStore {
    static ECCredentialsStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] init];
    });
    
    return sharedStore;
}

#pragma mark - Instance methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Check for existing credentials in Keychain
        if (![self load]) {
            // If there are none, create new ones
            self.credentials = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

/**
 Load an existing record for the credentials stored in the device.
 This method will look for existing credentials on Keychain.
 
 @return Returns `YES` on success, or `NO` in case there was no existing record.
 */
- (BOOL)load
{
    BOOL result = NO;
    
    NSData *data = [ECKeychain dataForAccount:kAccountName
                                    inService:kServiceName
                              withAccessGroup:nil];
    if (data) {
        self.credentials = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        result = YES;
        NSLog(@"ECCredentialsStore: Successfully loaded credentials");
    }
    else {
        NSLog(@"ECCredentialsStore: Error! Unable to load credentials");
    }
    
    return result;
}

- (BOOL)save
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.credentials];
    
    BOOL result = [ECKeychain setData:data
                           forAccount:kAccountName
                            inService:kServiceName
                      withAccessGroup:nil
                       synchronizable:NO];
    
    if (!result) {
        NSLog(@"ECCredentialsStore: Error! Unable to store credentials.");
    } else {
        NSLog(@"ECCredentialsStore: Successfully stored credentials");
    }
    
    return result;
}

- (BOOL)remove
{
    BOOL result = [ECKeychain deleteDataForAccount:kAccountName
                                   inService:kServiceName
                             withAccessGroup:nil];
    if (result) {
        self.credentials = [[NSMutableDictionary alloc] init];
        result = YES;
        NSLog(@"ECCredentialsStore: Successfully deleted credentials");
    }
    else {
        NSLog(@"ECCredentialsStore: Error! Unable to delete credentials");
    }
    
    return result;
}

#pragma mark - Setters & Getters

- (void)setAccessToken:(NSString *)token
{
    self.credentials[@"access_token"] = token;
}

- (NSString *)accessToken
{
    return self.credentials[@"access_token"];
}

- (void)setUsername:(NSString *)username
{
    self.credentials[@"username"] = username;
}

- (NSString *)username
{
    return self.credentials[@"username"];
}

- (void)setPassword:(NSString *)password
{
    self.credentials[@"password"] = password;
}

- (NSString *)password
{
    return self.credentials[@"password"];
}

- (void)setRefreshToken:(NSString *)token
{
    self.credentials[@"refresh_token"] = token;
}

- (NSString *)refreshToken
{
    return self.credentials[@"refresh_token"];
}

@end
