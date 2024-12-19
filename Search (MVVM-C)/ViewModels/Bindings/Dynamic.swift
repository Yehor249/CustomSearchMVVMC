//
//  Dynamic.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 12.12.2024.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
        
    init(_ v: T) {
        value = v
    }
}
