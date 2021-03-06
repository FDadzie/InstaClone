//
//  PostViewController.m
//  InstaClone
//
//  Created by fdadzie20 on 7/7/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "PostViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "PostCell.h"
#import <Parse/Parse.h>
#import "Post.h"


@interface PostViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray<Post *> *gramPosts;
@property (weak, nonatomic) IBOutlet UITableView *postTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postTableView.dataSource = self;
    self.postTableView.delegate = self;
    
    [self beginRefresh:(UIRefreshControl *)_refreshControl];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.postTableView insertSubview: self.refreshControl atIndex:0];
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (!error) {
            // do something with the data fetched
            self.gramPosts = posts;
            
        }
        else {
            // handle error
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {

        // Create NSURL and NSURLRequest
    NSURL *url = [NSURL URLWithString:@"http://0.0.0.0:4040/apps/instagramClone/browser/_User"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
           // ... Use the new data to update the data source ...

           // Reload the tableView now that there is new data
            [self.postTableView reloadData];

           // Tell the refreshControl to stop spinning
            [refreshControl endRefreshing];

        }];
    
        [task resume];
}

- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError *_Nullable error){
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_gramPosts count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *finalPost = self.gramPosts[indexPath.row];
    cell.postCaption.text = finalPost[@"caption"];
    cell.postUsername.text = finalPost[@"username"];
    
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
