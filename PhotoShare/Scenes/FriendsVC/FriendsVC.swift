//
//  FriendsVC.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 8.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class FriendsVC: UIViewController {

    // MARK: - IBOutlets & Properties
    private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var interactor: FriendsBusinessLogic!
    var router: FriendsRouterLogic!
    
    private var sectionType: SectionsType?
    var dataModel: [[PFUser]] = [[], []]
    private let titles = ["Invitations", "Friends"]
    
    // MARK: - Object lifecycle

    init(sectionType: SectionsType?) {
        super.init(nibName: nil, bundle: nil)
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
        FriendsConfigurator.shared.config(viewController: self)
    }
    
    // MARK: - Set tableView

    private func tableViewConfiguration() {
        tableView = UITableView()
        tableView.registerCell(FriendsTableViewCell.self)
        tableView.showsVerticalScrollIndicator = true
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // MARK: - Set searchController

    private func searchControllerConfiguration() {
        let vc = SearchResultsVC()
        let searchController = UISearchController(searchResultsController: vc)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    // MARK: - Firebase Observers

    func firebaseObserversConfiguration() {
        UserFirebase.observeUsers(type: "invites", event: .childAdded) { (user) in
            guard let user = user else { return }
            self.dataModel[0].insert(user, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
            self.navigationController?.tabBarItem.badgeValue = "\(self.dataModel[0].count)"
        }
        
        UserFirebase.observeUsers(type: "invites", event: .childRemoved) { (user) in
            guard let user = user,
                let index = self.dataModel[0].firstIndex(where: { (anotherUser) -> Bool in
                    return user.userID == anotherUser.userID
                }) else { return }
            self.dataModel[0].remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.navigationController?.tabBarItem.badgeValue = self.dataModel[0].count == 0 ? nil : "\(self.dataModel[0].count)"
        }
        
        UserFirebase.observeUsers(type: "friends", event: .childAdded) { (user) in
            guard let user = user else { return }
            self.dataModel[1].insert(user, at: 0)
            let indexPath = IndexPath(row: 0, section: 1)
            self.tableView.insertRows(at: [indexPath], with: .fade)
        }
        
        UserFirebase.observeUsers(type: "friends", event: .childRemoved) { (user) in
            guard let user = user,
                let index = self.dataModel[1].firstIndex(where: { (anotherUser) -> Bool in
                    return user.userID == anotherUser.userID
                }) else { return }
            self.dataModel[1].remove(at: index)
            let indexPath = IndexPath(row: index, section: 1)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseObserversConfiguration()
        tableViewConfiguration()
        
        searchControllerConfiguration()
    }
}

extension FriendsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(FriendsTableViewCell.self)
        cell.configureCell(name: dataModel[indexPath.section][indexPath.row].name)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let acceptAction = createAcceptAction(indexPath: indexPath)
        let acceptConfig = UISwipeActionsConfiguration(actions: [acceptAction])
        return acceptConfig
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let declineAction = createDeclineAction(indexPath: indexPath)
        let declineConfig = UISwipeActionsConfiguration(actions: [declineAction])
        return declineConfig
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return true
        default:
            return false
        }
    }
}

// NOTE: Should think to export this one in separate file

extension FriendsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Implement
        // NOTE: Make sure you are using indexPath[section], not indexPath[row]
    }
}

extension FriendsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        UserFirebase.searchUsers(text: searchText) { users in
            if let controller = searchController.searchResultsController as? SearchResultsVC {
                controller.results = users
                controller.tableView.reloadData()
            }
        }
    }
    
    func createAcceptAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Accept") { (action, view, completion) in
            UserFirebase.acceptInvite(userObject: self.dataModel[indexPath.section][indexPath.row], completion: { (status) in
                if status == true {
                    completion(true)
                }
                completion(false)
            })
        }
        action.image = #imageLiteral(resourceName: "accept")
        action.backgroundColor = UIColor.green
        return action
    }
    
    func createDeclineAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Decline") { (action, view, completion) in
            UserFirebase.declineInvite(userObject: self.dataModel[indexPath.section][indexPath.row], completion: { (status) in
                if status == true {
                    completion(true)
                }
                completion(false)
            })
        }
        action.image = #imageLiteral(resourceName: "close")
        action.backgroundColor = UIColor.red
        return action
    }
}

extension FriendsVC: FriendsDisplayLogic {}

// MARK: - Clean Swift Protocols

protocol FriendsDisplayLogic: class {}
