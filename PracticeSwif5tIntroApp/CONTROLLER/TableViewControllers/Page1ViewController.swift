//
//  Page1ViewController.swift
//  PracticeSwif5tIntroApp
//
//  Created by Kenshiro on 2020/12/19.
//

import UIKit
import SegementSlide

class Page1ViewController: UITableViewController,
//インポートしたSegementSlideにあるデリゲートを持ってきた
SegementSlideContentScrollViewDelegate,
//XMLを使うためのデリゲート
XMLParserDelegate {
    
    //RSSのパース内の現在の要素名を変数化
    var currentElementName:String!

    var newsItems  = [NewsItems]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableViewの色を指定
        tableView.backgroundColor = .clear
        
        //背景画像を置く
        //表示させる画像を設定
        let backImage = UIImage(named: "0")
        //背景画像を表示させるUIImageViewを設定(位置とサイズを設定)
        let backIamgeView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        //backIamgeViewに画像を反映
        backIamgeView.image = backImage
        //backIamgeViewをtabeleViewのbackgroundViewに反映(backIamgeViewが見えるようになる)
        self.tableView.backgroundView = backIamgeView
        
        //XMLをパース(構文解析)する
        //パースしたいページのURLを指定
        let newsUrl = "https://news.yahoo.co.jp/pickup/rss.xml"
        let url:URL = URL(string: newsUrl)!
        //XMLParserのインスタンス(parser)を作成
        var Parser = XMLParser()
        Parser = XMLParser(contentsOf:url)!
        //パースを開始
        Parser.delegate = self
        Parser.parse()
    }

    @objc var scrollView: UIScrollView{
        
        return tableView
    }
    // MARK: - Table view data source
    
    
    
    //テーブルビューのセクション数を設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //セクション内のセルの数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count
    }

    
    //セルの高さを設定
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/5
    }
    
    //セルを作成するメソッド
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsItem = self.newsItems[indexPath.row]
        
    //セルの設定
        //セルのスタイルを設定(2段で表示できるように.subtitleを指定した)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        //セルの背景色とフォント、文字色を設定
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        //行数の設定
        cell.textLabel?.numberOfLines = 3
        //表示させる内容の設定
        cell.textLabel?.text = newsItem.title
        
    //セルのサブタイトルを設定
        //文字色を設定
        cell.detailTextLabel?.textColor = .white
        //表示させる内容の設定
        cell.detailTextLabel?.text = newsItem.url
        
    //セルを表示させる
        return cell
    }
    
    //XML解析
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        
        if elementName == "item"{
            
            self.newsItems.append(NewsItems())
        }
        
            else{
                currentElementName = elementName
            }
        
        //newsItemsの中からXML解析を行うものを指定する
        func parser(_ parser:XMLParser, foundCharacters string: String){
            
            if self.newsItems.count > 0{
                let lastItem = self.newsItems[self.newsItems.count-1]
            
                switch self.currentElementName{
                    case "title": lastItem.title = string
                
                    case "link": lastItem.url = string
                
                    case "publishDate": lastItem.publishDate = string
                
                    default:break
                }
            }
        }
        
        //次のXML解析のためにcurrentElementNameの中を殻にする
        func parser(_ parser: XMLParser, didEndElement elementname: String, namespaceURI: String?, qualifiedName qName: String?){
            self.currentElementName = nil
        }
        
        //セルをリロードして内容をアップデートする
        func parserDidEndDocument(_ parser: XMLParser){
            self.tableView.reloadData()
        }
        
        //XML解析して取得したURLをwebViewControllerに渡して、ページを表示する
        func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath){
        
            let webViewController = WebViewController()
            //モーダルで画面遷移するときのトランジション(アニメーション)を設定
            webViewController.modalTransitionStyle = .crossDissolve
            
            //表示させるアイテムを選択(タップされたセルの内容を選択できるようにした)
            let newsItem = newsItems[indexPath.row]
            
            //選択されたURlをデータベースに保存
            UserDefaults.standard.setValue(newsItem.url, forKey: "url")
            present(webViewController, animated: true, completion: nil)
        }
    }
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
