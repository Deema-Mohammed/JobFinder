//
//  JobCell.swift
//  jopFinder
//
//  Created by Deema on 4/4/19.
//  Copyright © 2019 Deema. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var contener: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
