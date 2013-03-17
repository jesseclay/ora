//
//  WebViewController.m
//  ORA
//
//  Created by Brian Holder-Chow Lin On on 3/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "NetworkActivityIndicator.h"
#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebViewController


- (void)setUrl:(NSURL *)url
{
  _url = url;
}


- (void)viewWillAppear:(BOOL)animated
{
  if (self.url) {
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
  }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
  return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  [NetworkActivityIndicator show];
  [self.activityIndicator startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [NetworkActivityIndicator hide];
  [self.activityIndicator stopAnimating];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  
}


@end
