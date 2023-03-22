//
//  DetailsView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModelProtocol?
    
    private enum Constants {
        static let bottomContainerViewHeight: CGFloat = 120
    }
    
    private lazy var compositionLayout = DetailsCompositionLayout()
    
    private lazy var cellsFactory: DetailsCellsFactory = {
        DetailsCellsFactory(collectionView: collectionView)
    }()
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private let bottomContainerView = DetailsBottomViewContainer()
    
    private let bottomBackgroundView = CustomBackgroundView(.bottomBackgroundViewInDetails)
    
    private lazy var sections: [DetailsListSection]? = self.viewModel?.pageDataSource {
        didSet {
            updateCollectionView()
            bottomContainerView.configure(with: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegates()
        cellsFactory.registerCellsTypes()
        registerHeader()
        setNavigationButton()
    }
    
    private func setNavigationButton() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func registerHeader() {
        collectionView.register(DetailsColorSupplementaryView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DetailsColorSupplementaryView.cellID)
    }
    
    private func updateCollectionView() {
        self.sections?[0].photoItems?[0].isSelectedPhoto = true
        self.sections?[3].colorItems?[0].isSelectedColor = true
        DispatchQueue.main.async { [weak self] in
            guard let sections = self?.sections,
                    let self = self,
                    let layout = self.compositionLayout.createLayout(with: sections) else { return }
            self.collectionView.collectionViewLayout = layout
            self.activityIndicator.stopAnimating()
            self.collectionView.setContentOffset(.zero, animated: true)
        }
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeColor.backgroundColor
        
        let subviews = [
            collectionView,
            activityIndicator,
            bottomBackgroundView,
            bottomContainerView
        ]
        
        subviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.heightAnchor.constraint(equalToConstant: Constants.bottomContainerViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            bottomBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBackgroundView.topAnchor.constraint(equalTo: bottomContainerView.centerYAnchor)
        ])
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
                                                  withReuseIdentifier: DetailsColorSupplementaryView.cellID,
                                                  for: indexPath) as? DetailsColorSupplementaryView else {
                return UICollectionReusableView()
            }
            header.configure(with: sections?[indexPath.section].title ?? "")
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension DetailsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sections = self.sections else { return }
        switch sections[indexPath.section] {
        case .large:
            for index in 0...indexPath.count {
                self.sections?[indexPath.section + 1].photoItems?[index].isSelectedPhoto = false
            }
            self.sections?[indexPath.section + 1].photoItems?[indexPath.row].isSelectedPhoto = true
            collectionView.reloadData()
        case .small:
            for index in 0...indexPath.count {
                self.sections?[indexPath.section].photoItems?[index].isSelectedPhoto = false
            }
            self.sections?[indexPath.section].photoItems?[indexPath.row].isSelectedPhoto = true
            collectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: indexPath.section - 1),
                                        at: .left,
                                        animated: true)
            collectionView.reloadData()
        case .color:
            for index in 0...indexPath.count {
                self.sections?[indexPath.section].colorItems?[index].isSelectedColor = false
                self.sections?[indexPath.section].colorItems?[indexPath.row].isSelectedColor = true
                self.collectionView.reloadItems(at: [
                    IndexPath(row: index, section: indexPath.section),
                ])
            }
        default: return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let sections = self.sections else { return }
        switch sections[indexPath.section] {
        case .large:
            for index in 0...indexPath.count {
                self.sections?[indexPath.section + 1].photoItems?[index].isSelectedPhoto = false
            }
            self.sections?[indexPath.section + 1].photoItems?[indexPath.row].isSelectedPhoto = true
            collectionView.reloadData()
        
        default: return
        }
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func updateData() {
        sections = viewModel?.pageDataSource
    }
}
