//
//  LoginViewController.swift
//  PracticeSwif5tIntroApp
//
//  Created by Kenshiro on 2020/12/12.
//

import UIKit
//背景に動画を流すためにインポート
import AVFoundation

class LoginViewController: UIViewController {
    
    //Embed In→NavigationControllerを使っているけど、ナビゲーションバーを消す呪文
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
        }

    var animationplayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "opning", ofType:"mov" )
        animationplayer = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //avplyaer用のレイヤーを生成
        let playerLayer = AVPlayerLayer(player: animationplayer)
        
        //レイヤーの表示位置とサイズを設定
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        //レイヤーを配置する階層の位置を設定
        playerLayer.zPosition = -1
        
        //レイヤーをviweに反映
        view.layer.insertSublayer(playerLayer, at: 0)
        
        //レイヤーの色を設定
        playerLayer.videoGravity = .resizeAspectFill
        
        //レイヤーを無限ループする
        playerLayer.repeatCount = 0
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: animationplayer.currentItem, queue: .main){ (_) in
            
            self.animationplayer.seek(to: .zero)
            self.animationplayer.play()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
