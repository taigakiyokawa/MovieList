//
//  ListTableViewCell2.swift
//  MovieList
//
//  Created by Taiga KIYOKAWA on 2018/09/20.
//  Copyright © 2018年 Taiga KIYOKAWA. All rights reserved.
//

import UIKit

class ListTableViewCell2: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
