//
//  CollectionViewCell.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 17.12.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCollectionCell: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
        
        viewCollectionCell.translatesAutoresizingMaskIntoConstraints = false
        
        viewCollectionCell.clipsToBounds = true
        viewCollectionCell.layer.cornerRadius = 5
    }
    
    func commonInit(_ text: String) {
        self.label.text = text
    }
}

