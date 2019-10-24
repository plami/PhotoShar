//
//  SearchResultsVC.swift
//  PhotoShare
//
//  Created by Plamena Nikolova on 22.10.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class SearchResultsVC: UIViewController {

    var results: [PFUser] = []
    
    // MARK: - IBOutlets & Properties
    var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var interactor: SearchResultsBusinessLogic!
    var router: SearchResultsRouterLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfiguration()
    }
    
    // MARK: - Object lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
        SearchResultsConfigurator.shared.config(viewController: self)
    }
    
    // MARK: - Set tableView

    private func tableViewConfiguration() {
        tableView = UITableView()
        tableView.registerCell(FriendsTableViewCell.self)
        tableView.showsVerticalScrollIndicator = true
        // TODO: - When cells are ready, please set the proper behaviour here ...
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension SearchResultsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(FriendsTableViewCell.self)
        cell.configureCell(name: results[indexPath.row].name)
        if results[indexPath.row].isInvited || !results[indexPath.row].isFriend {
            cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "inviteFriends"))
        } else if results[indexPath.row].isFriend {
            cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "friends"))
        }
        return cell
    }
}

extension SearchResultsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !results[indexPath.row].isFriend
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let inviteAction = createInviteAction(indexPath: indexPath)
        let inviteConfig = UISwipeActionsConfiguration(actions: [inviteAction])
        return inviteConfig
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let uninviteAction = createUninviteAction(indexPath: indexPath)
        let uninviteConfig = UISwipeActionsConfiguration(actions: [uninviteAction])
        return uninviteConfig
    }
}

extension SearchResultsVC {
    func createInviteAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "invite") { (actioin, view, completion) in
            UserFirebase.invite(userID: self.results[indexPath.row].userID) { status in
                if status == true {
                    completion(true)
                    let cell = self.tableView.cellForRow(at: indexPath)
                    cell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "inviteFriends"))
                } else {
                    completion(false)
                }
            }
        }
        action.backgroundColor = UIColor.green
        action.image = #imageLiteral(resourceName: "inviteFriends")
        return action
    }
    
    func createUninviteAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "uninvite") { (action, view, completion) in
            UserFirebase.uninvite(userID: self.results[indexPath.row].userID, completion: { (status) in
                if status == true {
                    let cell = self.tableView.cellForRow(at: indexPath)
                    cell?.accessoryView = nil
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
        action.backgroundColor = UIColor.red
        action.image = #imageLiteral(resourceName: "uninviteFreinds")
        return action
    }
}

extension SearchResultsVC: SearchResultsDisplayLogic {
}

// MARK: - Clean Swift Protocols

protocol SearchResultsDisplayLogic: class {
}
