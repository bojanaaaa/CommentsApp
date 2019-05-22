//
//  PostsViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "PostsViewController.h"
#import "PostsManager.h"
#import "NavigationBar.h"
#import "TableViewCell.h"
#import "Post.h"
#import "CommentsViewController.h"
#import "Comment.h"
#import "CommentsManager.h"
#import "AddPostViewController.h"
@interface PostsViewController ()

@end

@implementation PostsViewController
@synthesize navigationBar,tableView,postsArray,activityIndicatorView,myCurrentUser;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    navigationBar.delegate=self;
    tableView.delegate=self;
    tableView.dataSource=self;
    
    activityIndicatorView.hidden=YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    navigationBar.beckButton.hidden=YES;
    navigationBar.logOutButton.hidden=NO;
    navigationBar.nameLabel.text=@"POSTS";
    navigationBar.photoSwitch.hidden=YES;
    navigationBar.addPost.hidden=NO;
    //tableView.hidden=YES;
    //[self.activityIndicatorView startAnimating];
    postsArray=[PostsManager sharedManager].postsArray;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopIndicator) name:@"newarray" object:nil];
    
}
-(void)stopIndicator{
    [self.activityIndicatorView stopAnimating];
    activityIndicatorView.hidesWhenStopped=YES;
    if([postsArray count])
    {tableView.hidden=NO;
        [tableView reloadData];}
}


- (void)addPostDelegate:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddPostViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"AddPostViewController"];
    [self.navigationController pushViewController:cartController animated:YES];
    
}
- (void)logOutButtonDelegate:(id)sender{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Logout"
                                 message:@"Are You Sure Want to Logout!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    BOOL rememberMe=NO;
                                    NSUserDefaults *def= [NSUserDefaults standardUserDefaults];
                                    [def setBool:rememberMe forKey:@"rememberMe"];
                                    [def synchronize];
                                    
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma Mark tableView delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    
    
    Post *post=[postsArray objectAtIndex:indexPath.row];
    
    cell.label1.text=post.title;
    cell.label2.text=post.body;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [postsArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Post *postAtRow=[postsArray objectAtIndex:indexPath.row];
    //NSMutableArray *newCommentsArray;
    //newCommentsArray=[[CommentsManager sharedManager]formCommentsArray:postAtRow.postID];
        
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommentsViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"CommentsViewController"];
    //cartController.commentsArray=newCommentsArray;
   // NSLog(@"ovde sam %li",(long)[cartController.commentsArray count]);
    cartController.myCurrentUser=myCurrentUser;
    
    cartController.post=postAtRow;
    [self.navigationController pushViewController:cartController animated:YES];
    
}


@end
