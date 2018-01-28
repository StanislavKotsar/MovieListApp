//
//  MovieViewCell.swift
//  MovieListApp
//
//  Created by Станислав Коцарь on 29.01.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
