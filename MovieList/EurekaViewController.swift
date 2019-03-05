//
//  EurekaViewController.swift
//  MovieList
//
//  Created by Taiga KIYOKAWA on 2018/09/11.
//  Copyright © 2018年 Taiga KIYOKAWA. All rights reserved.
//

import UIKit
import Eureka //追加

class EurekaViewController: FormViewController { //継承元を変更

//    var movieTitle: String = ""
    var watchDate: Date!
    
    var localization: String = ""
    var service: String = ""
    var theater: String = ""
    
    var movieArray: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    
//    var detailArray: [Dictionary<String, String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if saveData.array(forKey: "WATCHED") != nil {
            movieArray = saveData.array(forKey: "WATCHED") as! [Dictionary<String, String>]
        }

        form
            +++ Section("基本情報")
            <<< TextRow("title") { row in
                row.title = "タイトル"
                row.placeholder = "タイトルを入力"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }.onChange{ row in
                    let value = row.value
                    print(value)
                    
                }
            <<< DateInlineRow("") {
                $0.title = "鑑賞日"
                }.onChange() { row in
                    self.watchDate = row.value!
                    //選択された日を表示
                    print(self.watchDate)
                }
            //ここからセクション2のコード
            +++ Section("詳細情報")
            <<< PickerInlineRow<String>() { row in
                row.title = "字幕と音声"
                row.options = ["字幕", "吹替", "オリジナル", "音声解説", "字幕+吹替", "英語字幕", "その他"]
//                row.value = row.options.first
                }.onChange{[unowned self] row in
                    self.localization = row.value!
                    print(self.localization)
                }
            <<< PickerInlineRow<String>() { row in
                row.title = "利用サービス"
                row.options = ["映画館", "Blu-ray", "4K UHD", "DVD", "Netflix", "Hulu", "Amazon", "その他"]
//                row.value = row.options.first
                }.onChange{[unowned self] row in
                    self.service = row.value!
                    print(self.service)
                }
            <<< PickerInlineRow<String>() { row in
                row.title = "映像"
                row.options = ["2D", "3D", "IMAX", "IMAX 3D", "4DX", "4DX 3D", "その他"]
//                row.value = row.options.first
                }.onChange{[unowned self] row in
                    self.theater = row.value!
                    print(self.theater)
                }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        let values = form.values()
        let titleValue = values["title"] as! String?
        var movieTitle: String = ""
        var strDate: String = ""
        
//        detailArray.append([localization, service, theater])
        if titleValue != nil {
            movieTitle = (titleValue as String?)!
        }
        if watchDate != nil {
            strDate = dateString(date: watchDate)
        }
        
        if movieTitle != "" && strDate != "" {
            let watchedMovies = ["date": strDate, "title": movieTitle, "local": localization, "service": service, "effect": theater]
//            let detailMovies = ["local": localization, "service": service, "effect": theater]
            
            movieArray.append(watchedMovies)
            saveData.set(movieArray, forKey: "WATCHED")
            
//            detailArray.append(detailMovies)
//            saveData.set(detailArray, forKey: "DETAIL")
            
            let saved = UIAlertController(
                title: "保存完了",
                message: "登録が完了しました",
                preferredStyle: .alert
            )
            
            saved.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            
            self.present(saved, animated: true, completion: nil)
            print(movieArray)
            //初期化
            strDate = ""
            movieTitle = ""
            localization = ""
            service = ""
            theater = ""
            
        } else {
            let error = UIAlertController(
                title: "保存出来ません",
                message: "タイトルと鑑賞日を入力して下さい",
                preferredStyle: .alert
            )
            
            error.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            self.present(error, animated: true, completion: nil)
        }
    }
    
    private func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString: String = dateFormatter.string(from: date)
        return dateString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
