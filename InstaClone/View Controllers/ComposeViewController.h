//
//  ComposeViewController.h
//  InstaClone
//
//  Created by fdadzie20 on 7/8/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (strong, nonatomic) UIImage *savedPhoto;
@property (strong, nonatomic) UIImage *savedPhotoEdit;
@property (weak, nonatomic) IBOutlet UIImageView *previewPhoto;
@end

NS_ASSUME_NONNULL_END
