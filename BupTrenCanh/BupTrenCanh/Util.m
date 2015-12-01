//
//  Util.m
//  EAPB2BApp
//
//  Created by Joy Aether Limited.
//  Copyright (c) 2015 Joyaether.com. All rights reserved.
//

#import "Util.h"
#import "Macro.h"
@implementation Util

+ (Util *)sharedUtil {
    
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

#pragma mark Loading View
//- (MBProgressHUD *)progressView
//{
//    if (!_progressView) {
//        _progressView = [[MBProgressHUD alloc] initWithView:[Util appDelegate].window];
//        if (IS_IPAD()) {
//            _progressView.minSize = CGSizeMake(200.0f, 200.0f);
//        }
//        
//        _progressView.animationType = MBProgressHUDAnimationFade;
//        _progressView.dimBackground = NO;
//        [[Util appDelegate].window addSubview:_progressView];
//    }
//    return _progressView;
//}
//
//- (void)releaseLoadingView {
//    _progressView = nil;
//}
//
//- (void)showLoadingView {
//    [self showLoadingViewWithTitle:@""];
//}
//
//- (void)showLoadingViewWithTitle:(NSString *)title {
//    self.progressView.labelText = title;
//
//    [[Util appDelegate].window bringSubviewToFront:self.progressView];
//    [self.progressView show:NO];
//}
//
//- (void)hideLoadingView {
//
//    [self.progressView hide:NO];
//}

+ (AppDelegate *)appDelegate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return appDelegate;
}


+ (void)showConfirmAlert:(NSString *)title message:(NSString *)message delegate:(id)delegate {
    
    UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    [alrt show];
}

+ (void)showConfirmAlertWithMessage:(NSString *)message tag:(NSInteger)tag delegate:(id)delegate {
    UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:nil
                                                   message:message
                                                  delegate:delegate
                                         cancelButtonTitle:@"Close"
                                         otherButtonTitles:nil, nil];
    alrt.tag = tag;
    [alrt show];
}

+ (void)showConfirmAlertWithMessage:(NSString *)message delegate:(id)delegate {
    if (!message) {
        message = @"Connection time out";
    }
    [self showConfirmAlertWithMessage:message tag:0 delegate:delegate];
}

//+ (NSString*)getStringData:(DataElement *)data byKey:(NSString *)key {
//    PrimitiveElement *element = [[[data asObjectElement] valueForProperty:key] asPrimitiveElement];
//    if ([element valueAsString]) {
//        NSString *elementString = [element valueAsString];
//        
//        if (elementString.length == 0 || [elementString isEqual:[NSNull null]] || [elementString isEqualToString:@"(null)"]) {
//            return @"";
//        }
//        return [element valueAsString];
//    }
//    else if ([element valueAsDouble]) {
//        NSString *elementString = [NSString stringWithFormat:@"%.02f", [element valueAsDouble]];
//        return  elementString;
//    }
//    else if ([element valueAsFloat]) {
//        NSString *elementString = [NSString stringWithFormat:@"%.02f", [element valueAsFloat]];
//        return  elementString;
//    }
//    else if ([element valueAsInteger]) {
//        NSString *elementString = [NSString stringWithFormat:@"%d", [element valueAsInteger]];
//        return  elementString;
//    }
//    else if ([element valueAsNumber]) {
//        NSString *elementString = [NSString stringWithFormat:@"%@", [element valueAsNumber]];
//        return  elementString;
//    }
//    else {
//        NSString *elementString = [NSString stringWithFormat:@"%@", [element asObjectElement]];
//        if (elementString.length == 0 || [elementString isEqual:[NSNull null]] || [elementString isEqualToString:@"(null)"]) {
//            return @"";
//        }
//        
//        return elementString;
//    }
//}
//
//+ (NSString*)getStringData:(DataElement *)data byKey:(NSString *)key1 andKey:(NSString *)key2 {
//    PrimitiveElement *element = [[[[[[data asObjectElement] valueForProperty:key1] asObjectElement] asObjectElement] valueForProperty:key2] asPrimitiveElement];
//    if ([element valueAsString]) {
//        NSString *elementString = [element valueAsString];
//        
//        if (elementString.length == 0 || [elementString isEqual:[NSNull null]] || [elementString isEqualToString:@"(null)"]) {
//            return @"";
//        }
//        return [element valueAsString];
//    }
//    else if ([element valueAsNumber]) {
//        NSString *elementString = [NSString stringWithFormat:@"%@", [element valueAsNumber]];
//        return  elementString;
//    }
//    else if ([element valueAsDouble]) {
//        NSString *elementString = [NSString stringWithFormat:@"%.02f", [element valueAsDouble]];
//        return  elementString;
//    }
//    else if ([element valueAsFloat]) {
//        NSString *elementString = [NSString stringWithFormat:@"%.02f", [element valueAsFloat]];
//        return  elementString;
//    }
//    else if ([element valueAsInteger]) {
//        NSString *elementString = [NSString stringWithFormat:@"%d", [element valueAsInteger]];
//        return  elementString;
//    }
//    else {
//        NSString *elementString = [NSString stringWithFormat:@"%@", [element asObjectElement]];
//        if (elementString.length == 0 || [elementString isEqual:[NSNull null]] || [elementString isEqualToString:@"(null)"]) {
//            return @"";
//        }
//        
//        return elementString;
//    }
//}

+ (NSString*)convertDate:(NSDate*)date toStringFormat:(NSString*)format
{
    NSString *_dateString;
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:format];
    _dateString = [_dateFormatter stringFromDate:date];
    return _dateString;
}

+ (NSNumber*)convertFromDateStringToInt:(NSString *)date withDateFormat:(NSString*)format {
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    [objDateformat setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *objUTCDate = [objDateformat dateFromString:date];
    return [self convertDateToNumber:objUTCDate];
}

+ (NSNumber *)convertDateToNumber:(NSDate *)date {
    long long milliseconds = (long long)([date timeIntervalSince1970]*1000.0);
    return [NSNumber numberWithLongLong:milliseconds];
}

+ (NSString*)convert:(long long)dateValue toDateStringWithFormat:(NSString*)format {
    
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    [objDateformat setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateValue/1000];
//    NSTimeZone *gmtZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    [objDateformat setTimeZone:gmtZone];
    NSString *stringFromDate = [objDateformat stringFromDate:date];
    
    return stringFromDate;
}

+ (NSDate *)dateFromNumber:(long long)dateTime {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateTime/1000];
    return date;
}

+ (long long)currentDateTime {
    
    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setLocale:[NSLocale currentLocale]];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    long long currentDate = (long long)([date timeIntervalSince1970] *1000);
    return currentDate;
}

//+ (ArrayElement*)sort:(NSString*)key ascending:(BOOL)asc inTableView:(UITableView*)table byArray:(ArrayElement*)arr withLoadingView:(BOOL)boolean {
//    
//    NSMutableArray *sortArr = [[NSMutableArray alloc] initWithCapacity:10];
//    
//    for (int i = 0; i < arr.count; i++) {
//        ObjectElement *obj = [[arr valueAtIndex:i] asObjectElement];
//        [sortArr addObject:[obj proxyForJson]];
//    }
//    
//    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:asc];
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//    //
//    if (boolean == YES && table) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:table animated:YES];
//        if (IS_IPAD()) {
//            hud.minSize = CGSizeMake(200.0f, 200.0f);
//        } else {
//            //hud.frame = CGRectMake(SCREEN_WIDTH_PORTRAIT/2, SCREEN_HEIGHT_PORTRAIT/2, hud.size.width, hud.size.height);
//            hud.center = table.center;
//        }
//        [hud show:YES];
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // Do something...
//            [hud hide:YES];
//        });
//    }
//    
//    [sortArr sortUsingDescriptors:sortDescriptors];
//    ArrayElement *array = [[ArrayElement alloc] initWithArray:sortArr];
//    if (table) {
//        [table reloadData];
//    }
//    
//    return array;
//}
//
//+ (void)writeToSqliteDbWithSchema:(NSString *)schema
//                   andDataElement:(DataElement *)dataElement {
//    
//    // Write to sqlite db
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    SQLiteStore *store = [appDelegate sqliteStore];
//    if (![dataElement isArray]) {
//        [store createElement:[dataElement asObjectElement]
//                    inSchema:schema
//                   onSuccess:^(DataElement *element, NSString *schema) {
//                       NSLog(@"success");
//                   } onFailure:^(NSError *error, NSString *schema) {
//                       NSLog(@"failure: %@", error);
//                   }];
//    } else {
//        [store createElements:[dataElement asArrayElement]
//                     inSchema:schema
//                    onSuccess:^(DataElement *element, NSString *schema) {
//                        NSLog(@"success");
//                    } onFailure:^(NSError *error, NSString *schema) {
//                        NSLog(@"failure: %@", error);
//                    }];
//    }
//}

+ (NSString*)errorReadableString:(NSError*)error {
    NSString *string = [error localizedRecoverySuggestion];
    NSString *errorStr = [NSString
                       stringWithCString:[string cStringUsingEncoding:NSUTF8StringEncoding]
                       encoding:NSNonLossyASCIIStringEncoding];
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@"\"error\":\"" withString:@""];
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    if ([errorStr rangeOfString:@"Cannot insert the value NULL into column 'UnitID'"].location != NSNotFound) {
        return @"Unit Id is required";
    }
    
    if ([errorStr rangeOfString:@"sold_to_customer is not exists!"].location != NSNotFound) {
        return @"Sold to customer is required";
    }
    
    if ([errorStr rangeOfString:@"Currency is  not exists!"].location != NSNotFound) {
        return @"Currency is required";
    }
    
    if ([errorStr rangeOfString:@"Cannot insert the value NULL into column 'TargetDeliveryDate'"].location != NSNotFound) {
        return @"Delivery date is required";
    }
    
    if ([errorStr rangeOfString:@"Cannot insert the value NULL into column 'OrderQuantity'"].location != NSNotFound) {
        return @"You're not set quantity value";
    }
    
    return @"";
}

+ (UIColor *)colorWithHex:(NSString *)colorHex alpha:(CGFloat)alpha {
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[colorHex substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[colorHex substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[colorHex substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}

+ (void)changeStateOfPreviousButon:(UIButton*)previousButton andNextButton:(UIButton*)nextButton withDataOfPicker:(NSArray*)arr byIndex:(NSInteger)index
{
    if (index == 0) {
        previousButton.enabled = NO;
        nextButton.enabled = YES;
    }
    else if (index == ([arr count] - 1)) {
        previousButton.enabled = YES;
        nextButton.enabled = NO;
    }
    else {
        previousButton.enabled = YES;
        nextButton.enabled = YES;
    }
}

+ (NSString *)postReadyStringForImageData:(UIImage *)image
                                imageName:(NSString*)imageName {
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    if (!data)
        return nil;
    NSString *base64EncodedString = [data base64Encoding];
    if (!base64EncodedString)
        return nil;
    
    NSArray *strArr = [imageName componentsSeparatedByString:@"."];
    NSString *extension = [strArr lastObject];
    extension = [extension lowercaseString];
    if ([extension isEqualToString:@"jpg"]) {
        extension = @"jpeg";
    }
    return [NSString stringWithFormat:@"Content-Type: image/%@\r\nContent-Disposition: attachment; filename=%@\r\nContent-Transfer-Encoding: base64\r\n\r\n%@", @"jpeg", imageName, base64EncodedString];
}

+ (NSString*)configureErrorMessage:(NSString*)errorStr {
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@"\"error\":\"" withString:@""];
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@".\"" withString:@""];
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@"}" withString:@""];
    errorStr = [errorStr stringByReplacingOccurrencesOfString:@"\\u0027" withString:@"'"];
    
    return errorStr;
}

#pragma mark - DO SORT WHEN SHOW IN ORDER ITEM DETAIL PAGE
/*
 1. Color
 2. Sizes
 3. AC No. (*New)
 4. COO
 5. Composition (Fiber Content)
 6. Wash Symbols
 7. Care Instruction (Wash)
 */

//+ (ArrayElement*)sortOrderItemVariableArray:(ArrayElement*)arrElement {
//    ArrayElement *arrAfterSort = [[ArrayElement alloc] initWithArray:@[]];
//    
//    int numberOfColor = [self countNumberOfColor:arrElement];
//    int numberOfSizes = [self countNumberOfSizes:arrElement];
//    int numberOfComposition = [self countNumberOfComposition:arrElement];
//    int numberOfACNoAndCOO = [self countNumberOfACNo:arrElement] + [self countNumberOfCOO:arrElement];
//    
//    for (int i = 0; i < arrElement.count; i++) {
//        
//        for (int j = 0; j < arrElement.count; j++) {
//            ObjectElement *obj = [[arrElement valueAtIndex:j] asObjectElement];
//            NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//            
//            if (arrAfterSort.count == 0) {
//                if ([itemVariableName rangeOfString:@"Color"].location != NSNotFound) {
//                    [arrAfterSort addValue:obj];
//                    break;
//                }
//            }
//            
//            if (arrAfterSort.count >= numberOfColor && arrAfterSort.count < (numberOfSizes+numberOfColor)) {
//                if ([itemVariableName rangeOfString:@"Sizes"].location != NSNotFound) {
//                    [arrAfterSort addValue:obj];
//                    
//                    if (arrAfterSort.count == numberOfSizes) {
//                        break;
//                    }
//                }
//            }
//            
//            if (arrAfterSort.count >= (numberOfColor+numberOfSizes) && arrAfterSort.count < (numberOfColor+numberOfSizes+numberOfACNoAndCOO)) {
//                if (arrAfterSort.count == (numberOfColor+numberOfSizes)) {
//                    if ([itemVariableName rangeOfString:@"AC No."].location != NSNotFound) {
//                        [arrAfterSort addValue:obj];
//                        break;
//                    }
//                }
//                
//                if (arrAfterSort.count == (numberOfColor+numberOfSizes+1)) {
//                    if ([itemVariableName rangeOfString:@"COO"].location != NSNotFound) {
//                        [arrAfterSort addValue:obj];
//                        break;
//                    }
//                }
//            }
//            
//            if (arrAfterSort.count >= (numberOfColor+numberOfSizes+numberOfACNoAndCOO) && arrAfterSort.count < (numberOfColor+numberOfSizes+numberOfACNoAndCOO+numberOfComposition)) {
//                if ([itemVariableName rangeOfString:@"Composition"].location != NSNotFound) {
//                    [arrAfterSort addValue:obj];
//                    
//                    if ((arrAfterSort.count) == (numberOfColor+numberOfSizes+numberOfACNoAndCOO+numberOfComposition)) {
//                        break;
//                    }
//                }
//            }
//            
//            if (arrAfterSort.count == (numberOfColor+numberOfSizes+numberOfACNoAndCOO+numberOfComposition)) {
//                if ([itemVariableName rangeOfString:@"Wash Symbols"].location != NSNotFound) {
//                    [arrAfterSort addValue:obj];
//                    break;
//                }
//            }
//            
//            if (arrAfterSort.count == (numberOfColor+numberOfSizes+numberOfACNoAndCOO+numberOfComposition+1)) {
//                if ([itemVariableName rangeOfString:@"Care Instruction"].location != NSNotFound) {
//                    [arrAfterSort addValue:obj];
//                    break;
//                }
//            }
//            
//            if (arrAfterSort.count >= (numberOfColor+numberOfSizes+numberOfACNoAndCOO+numberOfComposition+2) && ![self notHaveInthePriorityList:itemVariableName] && ![self arrayElement:arrAfterSort notContainObject:obj]) {
//                
//                [arrAfterSort addValue:obj];
//            }
//        }
//        
//        
//    }
//    
//    NSLog(@"ARRAY AFTER SORT %d: %@", arrAfterSort.count, [arrAfterSort proxyForJson]);
//    
//    if (arrAfterSort.count < arrElement.count) {
//        return arrElement;
//    }
//    
//    return arrAfterSort;
//}
//
//+ (BOOL)arrayElement:(ArrayElement*)arrElement notContainObject:(ObjectElement*)objectElement {
//    BOOL contain = NO;
//    NSString *itemVariableName = [Util getStringData:objectElement byKey:@"item_variable_name"];
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *name = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([name isEqualToString:itemVariableName]) {
//            contain = YES;
//        }
//    }
//    
//    return contain;
//}

+ (BOOL)notHaveInthePriorityList:(NSString*)name {
    
    if ([name rangeOfString:@"Sizes"].location != NSNotFound) {
        return YES;
    }
    if ([name rangeOfString:@"Color"].location != NSNotFound) {
        return YES;
    }
    if ([name rangeOfString:@"AC No."].location != NSNotFound) {
        return YES;
    }
    if ([name rangeOfString:@"COO"].location != NSNotFound) {
        return YES;
    }
    if ([name rangeOfString:@"Composition"].location != NSNotFound) {
        return YES;
    }
    if ([name rangeOfString:@"Wash Symbols"].location != NSNotFound) {
        return YES;
    }
    if ([name rangeOfString:@"Care Instruction"].location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

//+ (int)countNumberOfColor:(ArrayElement*)arrElement {
//    int count = 0;
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([itemVariableName rangeOfString:@"Color"].location != NSNotFound) {
//            count++;
//        }
//    }
//    
//    return count;
//}
//
//+ (int)countNumberOfACNo:(ArrayElement*)arrElement {
//    int count = 0;
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([itemVariableName rangeOfString:@"AC No."].location != NSNotFound) {
//            count++;
//        }
//    }
//    
//    return count;
//}
//
//+ (int)countNumberOfCOO:(ArrayElement*)arrElement {
//    int count = 0;
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([itemVariableName rangeOfString:@"COO"].location != NSNotFound) {
//            count++;
//        }
//    }
//    
//    return count;
//}
//
//+ (int)countNumberWashSymbols:(ArrayElement*)arrElement {
//    int count = 0;
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([itemVariableName rangeOfString:@"Wash Symbols"].location != NSNotFound) {
//            count++;
//        }
//    }
//    
//    return count;
//}
//
//+ (int)countNumberCareInstruction:(ArrayElement*)arrElement {
//    int count = 0;
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([itemVariableName rangeOfString:@"Care Instruction"].location != NSNotFound) {
//            count++;
//        }
//    }
//    
//    return count;
//}
//
//+ (int)countNumberOfSizes:(ArrayElement*)arrElement {
//    int count = 0;
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([itemVariableName rangeOfString:@"Size"].location != NSNotFound) {
//            count++;
//        }
//    }
//    
//    return count;
//}
//
//+ (int)countNumberOfComposition:(ArrayElement*)arrElement {
//    int count = 0;
//    for (int i = 0; i < arrElement.count; i++) {
//        ObjectElement *obj = [[arrElement valueAtIndex:i] asObjectElement];
//        NSString *itemVariableName = [Util getStringData:obj byKey:@"item_variable_name"];
//        if ([itemVariableName rangeOfString:@"Composition"].location != NSNotFound) {
//            count++;
//        }
//    }
//    
//    return count;
//}

+ (float)heightOfLabelText:(NSString*)content textSize:(CGSize)textSize font:(UIFont*)font {
    if (SYSTEM_VERSION <7) {
        CGSize size = [content sizeWithFont:font
                          constrainedToSize:textSize
                              lineBreakMode:NSLineBreakByWordWrapping];
        return size.height;
    } else {
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              font, NSFontAttributeName,
                                              nil];
        CGRect requiredHeight = [content boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        return requiredHeight.size.height;
    }
}

@end
