// UIActivityIndicatorView+PFNetworking.m
//
// Copyright (c) 2013-2015 PFNetworking (http://afnetworking.com)
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

#import "UIActivityIndicatorView+PFNetworking.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import "PFHTTPRequestOperation.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#import "PFURLSessionManager.h"
#endif

@implementation UIActivityIndicatorView (PFNetworking)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
- (void)setAnimatingWithStateOfTask:(NSURLSessionTask *)task {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:PFNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:PFNetworkingTaskDidSuspendNotification object:nil];
    [notificationCenter removeObserver:self name:PFNetworkingTaskDidCompleteNotification object:nil];

    if (task) {
        if (task.state != NSURLSessionTaskStateCompleted) {
            if (task.state == NSURLSessionTaskStateRunning) {
                [self startAnimating];
            } else {
                [self stopAnimating];
            }

            [notificationCenter addObserver:self selector:@selector(af_startAnimating) name:PFNetworkingTaskDidResumeNotification object:task];
            [notificationCenter addObserver:self selector:@selector(af_stopAnimating) name:PFNetworkingTaskDidCompleteNotification object:task];
            [notificationCenter addObserver:self selector:@selector(af_stopAnimating) name:PFNetworkingTaskDidSuspendNotification object:task];
        }
    }
}
#endif

#pragma mark -

- (void)setAnimatingWithStateOfOperation:(PFURLConnectionOperation *)operation {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:PFNetworkingOperationDidStartNotification object:nil];
    [notificationCenter removeObserver:self name:PFNetworkingOperationDidFinishNotification object:nil];

    if (operation) {
        if (![operation isFinished]) {
            if ([operation isExecuting]) {
                [self startAnimating];
            } else {
                [self stopAnimating];
            }

            [notificationCenter addObserver:self selector:@selector(af_startAnimating) name:PFNetworkingOperationDidStartNotification object:operation];
            [notificationCenter addObserver:self selector:@selector(af_stopAnimating) name:PFNetworkingOperationDidFinishNotification object:operation];
        }
    }
}

#pragma mark -

- (void)af_startAnimating {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAnimating];
    });
}

- (void)af_stopAnimating {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopAnimating];
    });
}

@end

#endif
