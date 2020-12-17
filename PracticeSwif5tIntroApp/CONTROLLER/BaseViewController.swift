//
//  BaseViewController.swift
//  PracticeSwif5tIntroApp
//
//  Created by Kenshiro on 2020/12/13.
//

import UIKit
//画面をタブ切り替えできるようにする
import  SegementSlide

//親クラスを切り替えた
class BaseViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        
        //表示されるタブの初期位置を設定
    
    
        
        // Do any additional setup after loading the view.
    }
    
    override var headerView: UIView{
        let headerView = UIImage()
        headerView.
        
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
