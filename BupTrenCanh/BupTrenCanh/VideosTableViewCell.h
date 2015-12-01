//
//  VideosTableViewCell.h
//  BupTrenCanh
//
//  Created by mac on 12/1/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
@interface VideosTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet YTPlayerView *cellVideos;
- (void)setCell:(NSString*) title withID:(NSString*)idVideo;
@end
