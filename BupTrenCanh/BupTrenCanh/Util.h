//
//  Util.h
//  EAPB2BApp
//
//  Created by Joy Aether Limited.
//  Copyright (c) 2015 Joyaether.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppDelegate.h"
/** BOOL: Detect if device is the Simulator **/
#define IS_SIMULATOR ( TARGET_IPHONE_SIMULATOR )

#pragma - mark SYSTEM INFORMATION

/** String: System Name **/
#define SYSTEM_NAME ( [[UIDevice currentDevice ] systemName ] )

/** String: System Version **/
#define SYSTEM_VERSION ( [[[UIDevice currentDevice ] systemVersion ] integerValue] )

#pragma mark - SCREEN INFORMATION

/** Float: Portrait Screen Height **/
#define SCREEN_HEIGHT_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.height )

/** Float: Portrait Screen Width **/
#define SCREEN_WIDTH_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.width )

/** Float: Landscape Screen Height **/
#define SCREEN_HEIGHT_LANDSCAPE ((SYSTEM_VERSION >=8)?([[UIScreen mainScreen ] bounds ].size.height ):([[UIScreen mainScreen ] bounds ].size.width ))

/** Float: Landscape Screen Width **/
#define SCREEN_WIDTH_LANDSCAPE ((SYSTEM_VERSION >=8)?([[UIScreen mainScreen ] bounds ].size.width ):([[UIScreen mainScreen ] bounds ].size.height ))

/** CGRect: Portrait Screen Frame **/
#define SCREEN_FRAME_PORTRAIT ( CGRectMake( 0, 0, SCREEN_WIDTH_PORTRAIT , SCREEN_HEIGHT_PORTRAIT ) )

/** CGRect: Landscape Screen Frame **/
#define SCREEN_FRAME_LANDSCAPE ( CGRectMake( 0, 0, SCREEN_WIDTH_LANDSCAPE , SCREEN_HEIGHT_LANDSCAPE ) )

/** Float: Screen Scale **/
#define SCREEN_SCALE ([[UIScreen mainScreen] scale ] )

/** CGSize: Screen Size Portrait **/
#define SCREEN_SIZE_PORTRAIT ( CGSizeMake( SCREEN_WIDTH_PORTRAIT * SCREEN_SCALE , SCREEN_HEIGHT_PORTRAIT * SCREEN_SCALE ) )

/** CGSize: Screen Size Landscape **/
#define SCREEN_SIZE_LANDSCAPE ( CGSizeMake( SCREEN_WIDTH_LANDSCAPE * SCREEN_SCALE , SCREEN_HEIGHT_LANDSCAPE * SCREEN_SCALE ) )
/** UIColor: Color from RGB **/
#define COLOR_TEXT ( [UIColor colorWithRed:65.0/255.0 green:55.0/255.0 blue:50.0/255.0 alpha:1.0 ] )
#define COLOR_RIGHT ( [UIColor colorWithRed:233.0/255.0 green:127.0/255.0 blue:2.0/255.0 alpha:1.0 ] )
#define COLOR_WRONG ( [UIColor colorWithRed:189.0/255.0 green:21.0/255.0 blue:80.0/255.0 alpha:1.0 ] )
#define COLOR_BORDER ( [UIColor colorWithRed:73.0/255.0 green:10.0/255.0 blue:61.0/255.0 alpha:1.0 ] )

@interface Util : NSObject
//@property (strong, nonatomic) MBProgressHUD *progressView;

- (void)showLoadingView;
- (void)showLoadingViewWithTitle:(NSString *)title;
- (void)hideLoadingView;
- (void)releaseLoadingView;
+ (Util *)sharedUtil;
+ (AppDelegate *)appDelegate;

+ (void)showConfirmAlert:(NSString *)title message:(NSString *)message delegate:(id)delegate;
+ (void)showConfirmAlertWithMessage:(NSString *)message delegate:(id)delegate;
+ (void)showConfirmAlertWithMessage:(NSString *)message tag:(NSInteger)tag delegate:(id)delegate;

/**
 *Get string data from server, used for table view
 */
//+ (NSString*)getStringData:(DataElement *)data byKey:(NSString *)key;
/**
 *Get string data from server, used for label.text
 */
//+ (NSString*)getStringData:(DataElement *)data byKey:(NSString *)key1 andKey:(NSString *)key2;
/**
 *  Convert from NSDate to NSString
 */
+ (NSString*)convertDate:(NSDate*)date toStringFormat:(NSString*)format;
/**
 * Convert from date string to int
 */
+ (NSNumber*)convertFromDateStringToInt:(NSString*)date withDateFormat:(NSString*)format;
/**
 * Convert from date to int
 */
+ (NSNumber *)convertDateToNumber:(NSDate *)date;
/**
 *
 */

/*
 *Convert number to NSDate
 */
+ (NSDate *)dateFromNumber:(long long)dateTime;

+ (long long)currentDateTime;

+ (NSString*)convert:(long long)dateValue toDateStringWithFormat:(NSString*)format;

//+ (ArrayElement*)sort:(NSString*)key ascending:(BOOL)asc inTableView:(UITableView*)table byArray:(ArrayElement*)arr withLoadingView:(BOOL)boolean;
//
//+ (void)writeToSqliteDbWithSchema:(NSString *)schema
//                   andDataElement:(DataElement *)dataElement;

+ (NSString*)errorReadableString:(NSError*)error;
+ (UIColor *)colorWithHex:(NSString *)colorHex alpha:(CGFloat)alpha;
+ (void)changeStateOfPreviousButon:(UIButton*)previousButton andNextButton:(UIButton*)nextButton withDataOfPicker:(NSArray*)arr byIndex:(NSInteger)index;

+ (NSString *)postReadyStringForImageData:(UIImage *)image
                                imageName:(NSString*)imageName;

+ (NSString*)configureErrorMessage:(NSString*)errorStr;

//+ (ArrayElement*)sortOrderItemVariableArray:(ArrayElement*)arrElement;
+ (float)heightOfLabelText:(NSString*)content textSize:(CGSize)textSize font:(UIFont*)font;
@end
