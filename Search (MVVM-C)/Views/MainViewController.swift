//
//  MainViewController.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 19.12.2024.
//

import UIKit

class MainViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBAction func aboutButtonPressed(_ sender: Any) {
        coordinator?.showDetail()
    }
    weak var coordinator: AppCoordinator?
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main screen loaded")
        //mainLabel.text = "Hello \(viewModel?. ?? "Defoult")"
    }
}
