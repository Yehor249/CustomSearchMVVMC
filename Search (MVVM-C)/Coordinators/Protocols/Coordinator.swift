//
//  Coordinator.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 19.12.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
