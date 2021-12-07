//
//  UserTableViewCell.swift
//  chatApp
//
//  Created by loujain on 07/12/2021.
//

import UIKit

class UserTableViewCelll: UITableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
