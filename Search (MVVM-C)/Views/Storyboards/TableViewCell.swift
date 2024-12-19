//
//  TableViewCell.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 17.12.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ text: String) {
        self.label.text = text
    }
}
