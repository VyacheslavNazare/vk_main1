//
//  GroupViewController.swift
//  UI_app
//
//  Created by Вячеслав on 18.08.2021.
//

import UIKit


class GroupViewController: UIViewController {

    private let groupsAPI = GroupsAPI()
    private var groups: [GroupModel] = []
    private var filteredGroups: [GroupModel] = []
    


    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        DispatchQueue.global(qos: .userInteractive).async {
            self.groupsAPI.getGroups { [weak self] groups in
                guard let self = self else { return }
                self.filteredGroups = groups
                self.groups = groups
                self.tableView.reloadData()
                }
        }
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "moveToGalleryGroup" {
                guard
                    let destinationVC = segue.destination as? GalleryGroupViewController,
                    let indexSelectCell = tableView.indexPathForSelectedRow?.row
                else { return }
              
                let selectTitle = filteredGroups[indexSelectCell]
                destinationVC.title = selectTitle.name

                let selectAvatar = selectTitle.photo200
                GalleryGroupViewController.selectAvatarGroup = selectAvatar
                
                let selectDescription = selectTitle.description
                GalleryGroupViewController.selectDescriptionText = selectDescription

                let selectGroupId = String(filteredGroups[indexSelectCell].id)
                GalleryGroupAPI.selectGroupId = selectGroupId
            }
            return
        }
    }


extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.identifier) as! GroupTableViewCell
        cell.configure(group: filteredGroups[indexPath.row] as GroupModel)
        return cell
    }
}

extension GroupViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredGroups = groups
            tableView.reloadData()
            return
        }
        filteredGroups = groups.filter({ groupss -> Bool in
            groupss.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

