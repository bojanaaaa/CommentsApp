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

@implementation PostsViewController{
    NSMutableArray *filteredPosts;
    BOOL isFiltered;
    NSArray *posts;
}
@synthesize navigationBar,tableView,postsArray,activityIndicatorView,myCurrentUser,searchBar,noPosts,tableViewBottom;


- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered=NO;
    navigationBar.delegate=self;
    tableView.delegate=self;
    tableView.dataSource=self;
    searchBar.delegate=self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    activityIndicatorView.hidden=YES;
    // Do any additional setup after loading the view.
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText length]<3)
     {
         isFiltered=NO;
     }
    else {
        isFiltered=YES;
        filteredPosts= [NSMutableArray new];
      
        for(Post* p in postsArray ){
            NSRange nameTitleRange= [p.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameTitleRange.location!=NSNotFound){
                [filteredPosts addObject:p];
            }
            NSRange nameBodyRange= [p.body rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameBodyRange.location != NSNotFound)
            {
                BOOL add=YES;
                for(Post *po in filteredPosts)
                {
                    if([p.title isEqualToString:po.title]||[p.body isEqualToString:po.body])
                    {
                        add=NO;
                    }
                }
                if(add)
                {
                    [filteredPosts addObject:p];
                }
            }
            
        }
        if(filteredPosts.count==0){
            tableView.hidden=YES;
            noPosts.hidden=NO;
        }
    }
    [self.tableView reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    /*isFiltered=NO;
    noPosts.hidden=YES;
    tableView.hidden=NO;
    searchBar.text=@"";
    [self.tableView reloadData];
    [searchBar resignFirstResponder];*/
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
    [searchBar resignFirstResponder];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    navigationBar.beckButton.hidden=YES;
    navigationBar.logOutButton.hidden=NO;
    navigationBar.nameLabel.text=@"POSTS";
    navigationBar.photoSwitch.hidden=YES;
    navigationBar.addPost.hidden=NO;
    navigationBar.editPost.hidden=YES;
    noPosts.hidden=YES;
   // tableView.hidden=YES;
    postsArray=[PostsManager sharedManager].postsArray;
    
    BOOL chack=NO;
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    chack=[def boolForKey:@"reload"];
    
    if(chack==YES)
    {
        if([postsArray count])
        {
            [def setBool:NO forKey:@"reload"];
            postsArray=[PostsManager sharedManager].postsArray;
            //tableView.hidden=NO;
            [tableView reloadData];}
        
        }
   /* [self.activityIndicatorView startAnimating];
    [[PostsManager sharedManager]initManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeArray) name:@"newPostsArray" object:nil];*/
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
    if (isFiltered){
        Post *post=[filteredPosts objectAtIndex:indexPath.row];
        cell.label1.text=post.title;
        cell.label2.text=post.body;
    }
    else{
        Post *post=[postsArray objectAtIndex:indexPath.row];
        cell.label1.text=post.title;
        cell.label2.text=post.body;
        noPosts.hidden=YES;
        tableView.hidden=NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (isFiltered){
        
        return filteredPosts.count;
    }
    return [postsArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isFiltered)
        return 100;
    return 120;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Post *postAtRow=[postsArray objectAtIndex:indexPath.row];
        
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommentsViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"CommentsViewController"];
    cartController.myCurrentUser=myCurrentUser;
    
    cartController.post=postAtRow;
    [self.navigationController pushViewController:cartController animated:YES];
    
}
#pragma mark Keyboard change methods

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        self->tableViewBottom.constant = 10;
    }];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [self.view layoutIfNeeded];
    
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    
    if (keyboardFrameEnd.size.height > 0) {
        tableViewBottom.constant = keyboardFrameEnd.size.height + 30;
        
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}


/*-(void)makeArray{
 
 postsArray=[PostsManager sharedManager].postsArray;
 BOOL chack;
 Post * newPost=[Post new];
 NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
 chack=[def boolForKey:@"writenewpost"];
 if(chack==YES)
 {
 [def setBool:NO forKey:@"writenewpost"];
 newPost.postID= [def objectForKey:@"id"];
 newPost.userID=[def objectForKey:@"userId"];
 newPost.title=[def objectForKey:@"title"];
 newPost.body=[def objectForKey:@"body"];
 [def synchronize];
 
 [postsArray addObject:newPost];
 }
 [self.activityIndicatorView stopAnimating];
 activityIndicatorView.hidesWhenStopped=YES;
 if([postsArray count])
 {tableView.hidden=NO;
 [tableView reloadData];}
 }*/

/*-(void)stopIndicator{
 [self.activityIndicatorView stopAnimating];
 activityIndicatorView.hidesWhenStopped=YES;
 if([postsArray count])
 {tableView.hidden=NO;
 [tableView reloadData];}
 }*/

@end
