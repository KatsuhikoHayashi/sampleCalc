//
//  ViewController.m
//  sampleCalc
//
//  Created by 林克彦 on 2014/08/29.
//  Copyright (c) 2014年 Hayashidesu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shawCalc;

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
        
        // idをtagの項目にセットします。
        btn.tag = [[params objectForKey:@"id"] integerValue];
        
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

    //第４回追加分ここから
    
    // 押されたボタンにより処理を分岐します。
    switch (btn.tag) {
        case 0:     // 0〜9ボタン
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            NSLog(@"数字ボタンが押されました");
            self.shawCalc.text = [self.shawCalc.text stringByAppendingString:btn.titleLabel.text];
        break;
        default: // 上記以外
            break;
    }
    //第４回追加分ここまで
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
