//
//  PDFViewController.h
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "ViewController.h"

@interface PDFViewController : ViewController {
    BOOL isDocument;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property NSString *myPath;
@property NSInteger index;
@end
