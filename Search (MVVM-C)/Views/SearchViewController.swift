//
//  ViewController.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 07.12.2024.
//

import UIKit

class SearchViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelStatus: UILabel!
    
    var viewModel: SearchViewModel?
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка делегатов и dataSource
        tableView.dataSource = self
        collectionView.dataSource = self
        textField.delegate = self
        
        let tableNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(tableNib, forCellReuseIdentifier: "tableViewCustomCell")
        
        let collectionNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "collectionViewCustomCell")
        
        
        // Настройка текстового поля
        textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        
        // Привязка ViewModel
        bindViewModel()
        
        tableView.rowHeight = 60
        
        tableView.isHidden = true
    }
    
    func bindViewModel() {
        viewModel?.statusText.bind { [weak self] statusText in
            DispatchQueue.main.async {
                self?.labelStatus.text = statusText
            }
        }
        
        viewModel?.filteredBrands.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.searchHistory.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc func searchTextChanged(_ sender: UITextField) {
        let searchText = sender.text ?? ""
        viewModel?.searchTextFieldDidChange(searchText)
        
        // Управление видимостью tableView и collectionView
        if searchText.isEmpty {
            tableView.isHidden = true
            collectionView.isHidden = false
        } else {
            tableView.isHidden = false
            collectionView.isHidden = true
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.filteredBrands.value.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCustomCell", for: indexPath) as! TableViewCell
        
        let brand = viewModel?.filteredBrands.value[indexPath.row]
        
        if let name = brand?.name, let searchText = textField.text, !searchText.isEmpty {
            cell.label.attributedText = viewModel?.getHighlightedText(for: name, with: searchText)
        } else {
            cell.label.text = brand?.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBrand = viewModel?.filteredBrands.value[indexPath.row]
        
        if let brandName = selectedBrand?.name {
            viewModel?.addToSearchHistory(brandName)
            textField.text = brandName
        }
        
        coordinator?.showMain(brandNmae: selectedBrand?.name ?? "")
    }
    
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.searchHistory.value.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCustomCell", for: indexPath) as! CollectionViewCell
        
        let historyItem = viewModel?.searchHistory.value[indexPath.item]
        cell.label.text = historyItem // Обновите UI элемента, если он отличается
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 50)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.isHidden = true
    }
}
