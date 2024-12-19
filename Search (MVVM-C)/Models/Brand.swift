//
//  Brand.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 11.12.2024.
//

import Foundation

struct Brand {
    let name: String?
}

extension Brand {
    static let allBrands = [
        "Nike", "Adidas", "Zara", "H&M", "Gucci",
        "Louis Vuitton", "Supreme", "Balenciaga", "Prada", "Chanel",
        "Tommy Hilfiger", "Calvin Klein", "Ralph Lauren", "Versace",
        "Uniqlo", "Levi's", "The North Face", "Burberry", "Fendi",
        "Dior", "Under Armour", "Puma", "Off-White", "Stone Island", "Patagonia"
    ].map { Brand(name: $0) }
}
