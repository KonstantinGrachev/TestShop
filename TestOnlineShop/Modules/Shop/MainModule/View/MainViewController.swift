//
//  MainViewController.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol?
    
    private var cancellables = Set<AnyCancellable>()
    
    var hints = [String]()
    
    private enum Constants {
        static let searchBarLeadingInset: CGFloat = 50
        static let searchBarTrailingInset: CGFloat = -50
    }
    
    private lazy var compositionLayout = MainCompositionLayout()
    
    private lazy var cellsFactory: MainCellsFactory = {
        MainCellsFactory(collectionView: collectionView)
    }()
        
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let hintTableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.isHidden = true
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private lazy var sections: [MainListSection]? = self.viewModel?.pageData {
        didSet {
            updateCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.setMainNavigationBar()
        setDelegates()
        cellsFactory.registerCollectionViewCellsTypes()
        registerHeader()
        registerHintCellType()
        bindViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        searchBar.setupSearchBar()
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            guard let sections = self?.sections,
                    let self = self,
                    let layout = self.compositionLayout.createLayout(with: sections) else { return }
            self.collectionView.collectionViewLayout = layout
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(.zero, animated: true)
        }
    }
    
    private func bindViewModel() {
        captureSearchText()
        recieveHints()
    }
    
    private func captureSearchText() {
        viewModel?.searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] _ in self?.viewModel?.fetchSearchingData() })
            .store(in: &cancellables)
    }
    
    private func recieveHints() {
        viewModel?.searchResult
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] suggestions in
                guard let self = self else { return }
                let isEmptySuggestions = suggestions.count == 0
                self.hints = suggestions
                self.updateHintsUI(with: isEmptySuggestions)
            })
            .store(in: &cancellables)
    }
    
    private func updateHintsUI(with state: Bool) {
        hintTableView.isHidden = state
        hintTableView.reloadData()
    }
    
    private func registerHintCellType() {
        hintTableView.register(HintTableViewCell.self,
                               forCellReuseIdentifier: HintTableViewCell.cellID)
    }
    
    private func setDelegates() {
        tabBarController?.delegate = self
        searchBar.delegate = self
        viewModel?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        hintTableView.delegate = self
        hintTableView.dataSource = self
    }
    
    private func registerHeader() {
        collectionView.register(HeaderSupplementaryView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderSupplementaryView.cellID)
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeColor.backgroundColor
        
        let subviews = [
            searchBar,
            collectionView,
            hintTableView,
            activityIndicator
        ]
        
        subviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.searchBarLeadingInset),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: Constants.searchBarTrailingInset)
        ])
        
        NSLayoutConstraint.activate([
            hintTableView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            hintTableView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            hintTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            hintTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        sections?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sections = sections else { return UICollectionViewCell() }
        return cellsFactory.createCell(section: sections[indexPath.section],
                                       indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: HeaderSupplementaryView.cellID,
                                                  for: indexPath) as? HeaderSupplementaryView else {
                return UICollectionReusableView()
            }
            header.configure(with: sections?[indexPath.section].title ?? "")
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = sections?[indexPath.section] else { return }
        switch section {
        case .sales(let sales):
            if sales?[indexPath.row].name == "Reebok Classic" {
                viewModel?.moveToDetails()
            }
        default: break
        }
    }
}

extension MainViewController: MainViewModelDelegate {
    func updateData() {
        sections = viewModel?.pageData
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.cellID, for: indexPath) as? HintTableViewCell else { return UITableViewCell() }
        cell.configure(with: hints[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectSuggestion(with: indexPath)
    }
    
    private func selectSuggestion(with indexPath: IndexPath) {
        searchBar.text = hints[indexPath.row]
        hintTableView.isHidden = true
        hints = [String]()
        view.endEditing(true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            hintTableView.isHidden = true
        }
        viewModel?.searchText.send(searchText)
    }
}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        navigationItem.setMainNavigationBar()
    }
}
