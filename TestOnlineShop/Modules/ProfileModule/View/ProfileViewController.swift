//
//  ProfileViewController.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModelProtocol?
        
    private enum Constants {
        static let insetBtweenMenuTableViewAndTopContainerView: CGFloat = 10
        static let leadingIndentation: CGFloat = 30
        static let trailingIndentation: CGFloat = -30
        static let heightForRow: CGFloat = 60
    }
    
    private lazy var topContainerView: ProfileTopContainerView = {
        let view = ProfileTopContainerView()
        guard let firstname = viewModel?.user?.firstname,
              let lastname = viewModel?.user?.lastname else { return view }
        let image = viewModel?.user?.image?.toImage()
        view.configure(with: "\(firstname) \(lastname)", image: image)
        return view
    }()
    
    private func saveUser(with photo: UIImage) {
        let user = viewModel?.user
        user?.image = photo.toPngString()
        UserDefaults.standard.set(encodable: user, forKey: UserDefaultsKeys.user.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.cellID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.bounces = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setProfileNavigationBar()
        setupUI()
        setDelegates()
    }
    
    override func handlePickedImage(_ image: UIImage) {
        guard let firstname = viewModel?.user?.firstname,
              let lastname = viewModel?.user?.lastname else { return }
        topContainerView.configure(with: "\(firstname) \(lastname)", image: image)
        saveUser(with: image)
    }
    
    private func setDelegates() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        topContainerView.actionsDelegate = self
    }
    
    private func setupUI() {
        
        view.backgroundColor = ThemeColor.backgroundColor

        let subviews = [
            topContainerView,
            menuTableView
        ]
        
        subviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: menuTableView.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: menuTableView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: Constants.insetBtweenMenuTableViewAndTopContainerView),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingIndentation),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingIndentation),
            menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? MenuTableViewCell)?.disclosure == ProfileMenuDisclosureType.logout.rawValue {
            userLogout()
            showSignInVC()
        }
    }
    
    private func userLogout() {
        let user = viewModel?.user
        user?.isLogged = false
        UserDefaults.standard.set(encodable: user, forKey: UserDefaultsKeys.user.rawValue)
    }
    
    private func showSignInVC() {
        let viewModel = SignInViewModel()
        let vc = SignInViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuCellsDataSource.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.cellID, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: MenuCellsDataSource.menuItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
}

extension ProfileViewController: ProfileTopContainerViewActionsDelegate {
    func changePhotoButtonTapped() {
        showActionSheet()
    }
    
    func uploadItemButtonTapped() {
        print(#function)
    }
}
