//
//  ViewController.m
//  sampleCalc
//
//  Created by 林克彦 on 2014/08/29.
//  Copyright (c) 2014年 Hayashidesu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // ここからボタン描画
    
    // プロパティファイルの読み込み準備
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Buttons" ofType:@"plist"];
    NSArray *plist = [NSArray arrayWithContentsOfFile:path];
    
    // プロパティリストに登録されている設定の数だけ繰り返します。
    for(int i = 0; i < plist.count; i++){
        
        // ボタンオブジェクトを作成
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // プロパティリストに登録されている設定を、1個ずつ順番に取り出します。
        NSDictionary *params = [plist objectAtIndex:i];
        
        // 設定の中から"text"項目の文字列を取り出して、ボタンの上に表示される文字列にセットします。
        NSString *str = [params objectForKey:@"text"];
        [btn setTitle:str forState:UIControlStateNormal];
        
        
        // 設定の中から"x", "y", "width", "height"項目の文字列を取り出して、
        // 数値（double型）に変換してボタンの位置と大きさをセットします。
        CGFloat btnX = [[params objectForKey:@"x"] floatValue];
        CGFloat btnY = [[params objectForKey:@"y"] floatValue];
        CGFloat btnWidth = [[params objectForKey:@"width"] floatValue];
        CGFloat btnHeight = [[params objectForKey:@"height"] floatValue];
        btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        
        // ボタンの色をRGB形式で指定します。
        btn.backgroundColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.8 alpha:1.0];
        
        // ボタン押下時に実行されるアクション（btnTouchUpInside）を設定します。
        // これでどのボタンが押されても"btnTouchUpInside"が実行されるようになります。
        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        // ここでようやくボタンを画面上に表示します。
        [self.view addSubview:btn];
    }

}

-(void)btnTouchUpInside:(UIButton*)btn{

    // ボタンが押されたら、ログに押されたボタンの文字列を表示します。
    NSLog(@"%@",btn.titleLabel.text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
