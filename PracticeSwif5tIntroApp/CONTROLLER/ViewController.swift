//
//  ViewController.swift
//  PracticeSwif5tIntroApp
//
//  Created by Kenshiro on 2020/12/08.
//

import UIKit
//lottieのアニメーションを使うためにインポート
import Lottie


class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    //Embed In→NavigationControllerを使っているけど、ナビゲーションバーを消す呪文
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
        }
    
    var onboardJsonArray = ["1","2","3","4","5"]
    var onboardStringArray = ["世界中の情報にアクセス","欲しい情報をほしいときに","ニュースを仲間と共有も","新しい知見を手に入れましょう","今から始める"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //スクロールビューをページングできるようにした(1ページずつ止まる)
        scrollView.isPagingEnabled  = true
        
        setUpScrollViewLabel()
        setUpScrollViewAnimation()
    }
    
    //スクロールビューのラベルを設定するメソッド
    func setUpScrollViewLabel() {
        //scrollViewのデリゲートを持ってくる
        scrollView.delegate = self
        
        //スクロールビューの表示サイズを設定
            //今回はページングする画面が5こあるので、幅はviewの5倍を設定している
        scrollView.contentSize = CGSize(width: view.frame.size.width*5, height: scrollView.frame.size.height)
        
        
        for i in 0...4{
            //ラベルを配置する位置とサイズを指定
            let onboadlabel = UILabel(frame: CGRect(x:CGFloat(i)*view.frame.size.width, y:view.frame.size.height/3,width: scrollView.frame.size.width,height: scrollView.frame.size.height))
            
            //ラベルの文字デザインを設定（UiFontの太字で中央揃えにしている）
            onboadlabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboadlabel.textAlignment = .center
            
            //ラベルに反映させる文字を設定
            onboadlabel.text = onboardStringArray[i]
            
            //ラベルをスクロールビューに反映させる
            scrollView.addSubview(onboadlabel)
        }
    }
    
    //lottieアニメーションをスクロールビューで動かすためのメソッド
    func setUpScrollViewAnimation() {
        for i in 0...4{
            let lottieView = AnimationView()
            let lottieAnimation = Animation.named(onboardJsonArray[i])
    
            //lottieを表示させるアニメーションビューの位置とサイズを設定
            lottieView.frame = CGRect(x:CGFloat(i)*view.frame.size.width, y:0,width: view.frame.size.width,height: view.frame.size.height)
            
            //アニメーションビューの挙動を設定
            lottieView.contentMode = .scaleAspectFit
            lottieView.loopMode = .loop
            
            //lottieをアニメーションビューに反映させて表示する
            lottieView.animation = lottieAnimation
            lottieView.play()
            scrollView.addSubview(lottieView)
        }
    }
}

