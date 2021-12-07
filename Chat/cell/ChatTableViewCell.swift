//
//  ChatTableViewCell.swift
//  chatApp
//
//  Created by loujain on 07/12/2021.
//

import UIKit
import Firebase
class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userChat: UILabel!
    @IBOutlet weak var chatMessage: UILabel!
    
    @IBOutlet weak var textMessage: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
