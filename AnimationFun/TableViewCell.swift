//
//  TableViewCell.swift
//  AnimationFun
//
//  Created by user user on 28/08/2018.
//  Copyright © 2018 Believerz. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var markerImage: UIImageView!
    @IBOutlet weak var LocName: UILabel!
    @IBOutlet weak var address: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
