//
//  ParticipantListViewController.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit

class ParticipantListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterListDelegate {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterBtn: UIView!
    
    // MARKL Properties
    var participants: [Participant] = []
    var filteredParticipants: [Participant] = []
    var searchController: UISearchController!
    var searchQuery: String = ""
    var selectedSkillsFilter: [Bool] = []
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        self.initSearch()
        self.setupFilterBtn()
        NetworkManager.shared.getParticipants { (result) in
            self.participants = result
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Hack the North"
    }
    
    // MARK: Helper functions
    private func initSearch() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        let searchBar = self.searchController.searchBar
        searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar
    }
    
    private func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.initNibs()
    }
    
    private func initNibs() {
        let summaryNib = UINib(nibName: ParticipantSummaryTableViewCellNib, bundle: nil)
        self.tableView.register(summaryNib, forCellReuseIdentifier: ParticipantSummaryTableViewCellIdentifier)
    }
    
    private func setupFilterBtn() {
        self.filterBtn.layer.cornerRadius = 32.0
//        self.filterBtn.layer.masksToBounds = true
        self.filterBtn.layer.shadowColor = UIColor.lightGray.cgColor
        self.filterBtn.layer.shadowOpacity = 1
        self.filterBtn.layer.shadowOffset = CGSize(width: 0, height: 20)
        self.filterBtn.layer.shadowRadius = 20
        
    }
    
    // UITableView Delegate and Datasource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantSummaryTableViewCellIdentifier, for: indexPath) as? ParticipantSummaryTableViewCell {
            if isFiltered() {
                cell.configureCell(filteredParticipants[indexPath.row])
            } else {
                cell.configureCell(participants[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let detailedVC = storyBoard.instantiateViewController(withIdentifier: ParticipantDetailsViewControllerIdentifier) as? ParticipantDetailsViewController {
            if isFiltered() {
                detailedVC.participant = self.filteredParticipants[indexPath.row]
            } else {
                detailedVC.participant = self.participants[indexPath.row]
            }
            self.navigationItem.title = "All Users"
            self.navigationController?.pushViewController(detailedVC, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered() {
            return self.filteredParticipants.count
        }
        return self.participants.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    private func isFiltered() -> Bool {
        return self.searchQuery != "" || self.selectedSkillsFilter != []
    }
    
    // MARK: Custom Filter
    
    @IBAction func onFilterBtnTapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let filterVC = storyBoard.instantiateViewController(withIdentifier: FilterViewControllerIdentifier) as? FilterViewController {
            if self.selectedSkillsFilter != [] {
                filterVC.selectedCategories = self.selectedSkillsFilter
            }
            filterVC.delegate = self
            self.present(filterVC, animated: true, completion: nil)
        }
    }
    
    func receiveFilterInformation(selectedCategories: [Bool]) {
        self.selectedSkillsFilter = selectedCategories
        self.filterWithCurrentSettings()
        self.tableView.reloadData()
    }
    
    /**
     Used to filter by both category and name
     */
    func filterWithCurrentSettings() {
        if self.selectedSkillsFilter != [] {
            self.filteredParticipants = self.participants.filter { participant in
                let skills = participant.skills
                
                for i in 0..<self.selectedSkillsFilter.count {
                    if self.selectedSkillsFilter[i] {
                        let index = skillsToColour.index(skillsToColour.startIndex, offsetBy: i)
                        let skill = skillsToColour.keys[index]
                        for s in skills {
                            if s.0 == skill {
                                return true
                            }
                        }
                    }
                }
                return false
            }
        } else {
            self.filteredParticipants = self.participants
        }
        
        if self.searchQuery != "" {
            self.filteredParticipants = self.filteredParticipants.filter { participant in
                if let name = participant.name {
                    return name.lowercased().contains(self.searchQuery.lowercased())
                }
                return false
            }
        }
        
    }

}

/**
 Search bar methods
 */
extension ParticipantListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchQuery = self.searchController.searchBar.text!
        self.filterContentForSearchText(searchText: self.searchQuery)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filterWithCurrentSettings()
        tableView.reloadData()
    }
}
