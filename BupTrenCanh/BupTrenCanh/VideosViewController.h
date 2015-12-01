//
//  VideosViewController.h
//  BupTrenCanh
//
//  Created by mac on 9/20/15.
//  Copyright © 2015 Viet Anh Dang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YTPlayerView.h"
#import "VideosTableViewCell.h"
#import "youtube-player-ios-example/YouTubeiOSPlayerHelper.h"
@interface VideosViewController : ViewController<UITableViewDataSource,UITableViewDelegate> {
    NSArray *dataArray;
}

@end
