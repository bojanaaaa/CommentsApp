//
//  CommentsViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "CommentsViewController.h"
#import "PostsViewController.h"
#import "SingleCommentViewController.h"
#import "Post.h"
#import "Comment.h"
#import "Album.h"
#import "Photo.h"
#import "CommentsManager.h"
#import "PhotoManager.h"
#import "AlbumManager.h"
#import "PostsManager.h"
#import "TableViewCell.h"
#import "EditPostViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

@synthesize navigationBar,comment,commentsArray,post,tableView,titleLabel,bodyLabel,activityIndicatorView,myCurrentUser,noCommentsLabel,activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postIsDeleted:) name:@"postisdeleted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postIsNotDeleted:) name:@"postisnotdeleted" object:nil];
    navigationBar.delegate=self;
    
    
     // Do any additional setup after loading the view.
    
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.hidden=YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    navigationBar.beckButton.hidden=NO;
    navigationBar.logOutButton.hidden=YES;
    navigationBar.nameLabel.text=@"POST";
    navigationBar.photoSwitch.hidden=YES;
    navigationBar.addPost.hidden=YES;
    navigationBar.editPost.hidden=NO;
    noCommentsLabel.hidden=YES;
    activityIndicator.hidden=YES;
    titleLabel.text=post.title;
    bodyLabel.text=post.body;
    
    [self.activityIndicatorView startAnimating];
    [[CommentsManager sharedManager]formCommentsArray:post.postID];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopIndicator) name:@"newarray" object:nil];
    
}
-(void)stopIndicator{
    commentsArray=[CommentsManager sharedManager].postcommentsArray;
    [self.activityIndicatorView stopAnimating];
    activityIndicatorView.hidesWhenStopped=YES;
    if([commentsArray count])
    {tableView.hidden=NO;
        [tableView reloadData];}
    else {
        noCommentsLabel.hidden=NO;
    }
}

- (void)backButtonDelegate:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)editPostDelegate:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditPostViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"EditPostViewController"];
    cartController.post=post;
    [self.navigationController pushViewController:cartController animated:YES];
    
}
-(void)deletePost{
    
    tableView.hidden=YES;
    titleLabel.hidden=YES;
    bodyLabel.hidden=YES;
    activityIndicator.hidden=NO;
    [self.activityIndicator startAnimating];
    [[PostsManager sharedManager]deletePost:post];
}
-(void)postIsDeleted:(NSNotification *)notification{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Notification"
                                 message:@"Post Is Deleted!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   BOOL chack=YES;
                                   NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                                   [def setBool:chack forKey:@"reload"];
                                   self->activityIndicator.hidden=YES;
                                   [self.activityIndicator stopAnimating];
                                 [self.navigationController popViewControllerAnimated:YES];
                                   
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)postIsNotDeleted:(NSNotification *)notification{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Notification"
                                 message:@"Post Is Not Deleted!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   
                                   self->tableView.hidden=NO;
                                   self->titleLabel.hidden=NO;
                                   self->bodyLabel.hidden=NO;
                                   self->activityIndicator.hidden=YES;
                                   [self.activityIndicator stopAnimating];

                                   
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)deletePostButton:(id)sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Logout"
                                 message:@"Are You Sure Want to Delete Post!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    [self deletePost];
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma Mark tableView delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    
    
    Comment *comment=[commentsArray objectAtIndex:indexPath.row];
    
    cell.label1.text=comment.name;
    cell.label2.text=comment.email;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [commentsArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Comment *commentAtRow=[commentsArray objectAtIndex:indexPath.row];
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SingleCommentViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"SingleCommentViewController"];
    cartController.comment=commentAtRow;
    cartController.myCurrentUser=myCurrentUser;
    cartController.mainPost=post;
    cartController.index=indexPath.row;
    [self.navigationController pushViewController:cartController animated:YES];
    
}


/*/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
