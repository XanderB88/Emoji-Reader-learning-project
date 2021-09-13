//
//  EmojiTableViewCell.swift
//  Emoji Reader (learning project)
//
//  Created by Alexander on 13.09.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     
    func setConfiguration(emoji: Emoji) {
        self.emojiLabel?.text = emoji.emoji
        self.nameLabel?.text = emoji.name
        self.descriptionLabel?.text = emoji.description
    }
}
