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
NSInteger calcVal;  // 計算値（保存用）
NSInteger calcCode; // 計算記号（保存用）
bool calcMode;      // 計算モード
                    // 0:まだわかんない
                    // 10:足し算するよ
                    // 11:引き算するよ
                    // 12:掛け算するよ
                    // 13:割り算するよ

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
        
        // 計算機の状態を初期化します。
        [self initCalc];
        
    }

}

-(void)btnTouchUpInside:(UIButton*)btn{

    NSInteger val;  // 計算値の数字変換用
    
    // ボタンが押されたら、ログに押されたボタンの文字列を表示します。
    NSLog(@"%@",btn.titleLabel.text);
    
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
            if(calcMode == false){
                self.shawCalc.text = btn.titleLabel.text;
                calcMode = true;
            }else{
                val = [self.shawCalc.text intValue] * 10 + [btn.titleLabel.text intValue];
                self.shawCalc.text = [NSString stringWithFormat:@"%d", val];
            }
            break;

        case 10:    // +、-、×、÷ボタン
        case 11:
        case 12:
        case 13:
            NSLog(@"記号ボタンが押されました");
            [self execCalc:calcCode];
            calcVal = [self.shawCalc.text intValue];
            calcCode = btn.tag;
            calcMode = false;
            break;
            
        case 14:
            NSLog(@"=ボタンが押されました");
            [self execCalc:calcCode];
            calcVal = 0;
            calcCode = 0;
            calcMode = false;
            break;
        
        case 15:
            NSLog(@"Cボタンが押されました");
            [self initCalc];
            break;
            
        default: // 上記以外
            break;
    }
    NSLog(@"val:[%ld] code:[%d] mode:[%d]", (long)calcVal, calcCode, calcMode);
}

- (void)initCalc{
    self.shawCalc.text = @"0";
    calcVal = 0;
    calcCode = 0;
    calcMode = false;

}

- (void)execCalc:(NSInteger)code{
   
    NSInteger val;  // 計算値の数字変換用
    
    switch (code) {
        case 0:     // 計算しない
            val = [self.shawCalc.text intValue];
            break;
            
        case 10:    // 足し算
            NSLog(@"%d + %d", calcVal, [self.shawCalc.text intValue]);
            val = calcVal + [self.shawCalc.text intValue];
            break;
            
        case 11:    // 引き算
            NSLog(@"%d - %d", calcVal, [self.shawCalc.text intValue]);
            val = calcVal - [self.shawCalc.text intValue];
            break;
            
        case 12:    // 掛け算
            NSLog(@"%d × %d", calcVal, [self.shawCalc.text intValue]);
            val = calcVal * [self.shawCalc.text intValue];
            break;
            
        case 13:    // 割り算
            NSLog(@"%d ÷ %d", calcVal, [self.shawCalc.text intValue]);
            val = calcVal / [self.shawCalc.text intValue];
            break;
            
        default:
            break;
    }
    self.shawCalc.text = [NSString stringWithFormat:@"%d", val];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
