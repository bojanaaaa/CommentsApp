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

@synthesize navigationBar,comment,commentsArray,post,tableView,titleLabel,bodyLabel,activityIndicatorView,myCurrentUser,noCommentsLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    navigationBar.delegate=self;
    
    titleLabel.text=post.title;
    bodyLabel.text=post.body;
     // Do any additional setup after loading the view.
    
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.hidden=YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    navigationBar.beckButton.hidden=NO;
    navigationBar.logOutButton.hidden=YES;
    navigationBar.nameLabel.text=@"COMMENTS";
    navigationBar.photoSwitch.hidden=YES;
    navigationBar.addPost.hidden=YES;
    navigationBar.editPost.hidden=NO;
    noCommentsLabel.hidden=YES;

    
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
