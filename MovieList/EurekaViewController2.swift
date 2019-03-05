//
//  EurekaViewController2.swift
//  MovieList
//
//  Created by Taiga KIYOKAWA on 2018/09/20.
//  Copyright © 2018年 Taiga KIYOKAWA. All rights reserved.
//

import UIKit
import Eureka

class EurekaViewController2: FormViewController {

    var releaseDate: Date!
    
    var movieArray: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        if saveData.array(forKey: "RELEASE") != nil {
            movieArray = saveData.array(forKey: "RELEASE") as! [Dictionary<String, String>]
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
                $0.title = "公開日"
                }.onChange() { row in
                    self.releaseDate = row.value!
                    //選択された日を表示
                    print(self.releaseDate)
            }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        let values = form.values()
        let titleValue = values["title"] as! String?
        var movieTitle: String = ""
        var strDate: String = ""
        
        if titleValue != nil {
            movieTitle = (titleValue as String?)!
        }
        if releaseDate != nil {
            strDate = dateString(date: releaseDate)
        }
        
        if movieTitle != "" {
            let releaseMovies = ["date": strDate, "title": movieTitle]
            
            movieArray.append(releaseMovies)
            saveData.set(movieArray, forKey: "RELEASE")
            
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
            strDate = ""
            movieTitle = ""
        } else {
            let error = UIAlertController(
                title: "保存出来ません",
                message: "タイトルを入力して下さい",
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
