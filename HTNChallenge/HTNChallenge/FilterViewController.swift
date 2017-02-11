//
//  FilterViewController.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-10.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit

// Used to pass information between filter modal and the participants list VC
protocol FilterListDelegate {
    func receiveFilterInformation(selectedCategories: [Bool]);
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var selectedCategories: [Bool] = []
    var delegate: FilterListDelegate?
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        
        if selectedCategories == [] {
            for _ in 0..<skillsToColour.count {
                selectedCategories.append(true)
            }
        }
    }
    
    func initNibs() {
        let skillNib = UINib(nibName: FilterSkillCategoryTableViewCellNib, bundle: nil)
        self.tableView.register(skillNib, forCellReuseIdentifier: FilterSkillCategoryTableViewCellIdentifier)
    }
    
    private func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.initNibs()
    }

    // MARK: Tableview delegate and datasource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterSkillCategoryTableViewCellIdentifier, for: indexPath) as? FilterSkillCategoryTableViewCell {
            let index = skillsToColour.index(skillsToColour.startIndex, offsetBy: indexPath.row)
            cell.configureCell(skill: skillsToColour.keys[index], isChecked: self.selectedCategories[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterSkillCategoryTableViewCellIdentifier, for: indexPath) as? FilterSkillCategoryTableViewCell {
            
            cell.toggleCheckbox()
            self.selectedCategories[indexPath.row] = !self.selectedCategories[indexPath.row]
            print(selectedCategories)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skillsToColour.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: IBActions
    @IBAction func onCancelBtnTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onApplyBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.receiveFilterInformation(selectedCategories: self.selectedCategories)
    }
}
