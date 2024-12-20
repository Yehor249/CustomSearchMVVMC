//
//  ViewModel.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 12.12.2024.
//

import Foundation
import UIKit

class SearchViewModel {
    var filteredBrands: Dynamic<[Brand]> = Dynamic([])
    var searchHistory: Dynamic<[String]> = Dynamic([])
    
    private let allBrands = Brand.allBrands
    
    var statusText: Dynamic<String> = Dynamic("Start typing to search...")
    
    init() {
        filteredBrands.value = allBrands
        searchHistory.value = []
    }
    
    func searchTextFieldDidChange(_ searchText: String) {
        if searchText.isEmpty {
            filteredBrands.value = allBrands
            statusText.value = "Start typing to search..."
        } else {
            filteredBrands.value = allBrands.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
            statusText.value = filteredBrands.value.isEmpty ? "No results found" : "Showing results for '\(searchText)'"
        }
    }
    
    func addToSearchHistory(_ text: String) {
        if !searchHistory.value.contains(text) {
            searchHistory.value.append(text)
        }
    }
    
    func getHighlightedText(for text: String, with searchText: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text)
        let range = (text.lowercased() as NSString).range(of: searchText.lowercased())
        
        if range.location != NSNotFound {
            attributedText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], range: range)
        }
        
        return attributedText
    }
}
