//
//  HomeController.m
//  Cool
//
//  Created by ouyang on 2022/10/13.
//

#import "HomeController.h"
#import "NextController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    UIButton *nextBtn = [UIButton buttonWithTitle:@"下一页" titleColor:[UIColor blueColor] highlightedTitleColor:[UIColor blueColor] font:[UIFont systemFontOfSize:14] target:self selector:@selector(nextvcAction)];
    nextBtn.frame = CGRectMake(100, 80, 100, 40);
    nextBtn.center = self.view.center;
    [self.view addSubview:nextBtn];
}

-(void)nextvcAction{
    [self.navigationController pushViewController:[[NextController alloc]init] animated:YES];
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
