//
//  WebViewController.swift
//  PracticeSwif5tIntroApp
//
//  Created by Kenshiro on 2020/12/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate {

    var webView = WKWebView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //webViewのサイズを設定
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-50)
        
        //viweにwebViewを反映
        view.addSubview(webView)
        
        //データベースに保存されたURLを呼び出す
        let urlString = UserDefaults.standard.object(forKey: "url")
        
        //呼び出したURLをURLRequest型に変換
        let url = URL(string: urlString as! String)
        let request = URLRequest(url: url!)
        
        //webViewをロードして任意のページを表示
        webView.load(request)
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
