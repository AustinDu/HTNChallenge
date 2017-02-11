//
//  ParticipantDetailsViewController.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit

class ParticipantDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var participant: Participant?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
    }
    
    private func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.initNibs()
    }
    
    private func initNibs() {
        let infoNib = UINib(nibName: ParticipantDetailedInfoTableViewCellNib, bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: ParticipantDetailedInfoTableViewCellIdentifier)
        let locationNib = UINib(nibName: ParticipantLocationTableViewCellNib, bundle: nil)
        tableView.register(locationNib, forCellReuseIdentifier: ParticipantLocationTableViewCellIdentifier)
    }
    
    // MARK: Tableview delegate and datasource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantDetailedInfoTableViewCellIdentifier, for: indexPath) as? ParticipantDetailedInfoTableViewCell {
                cell.configureCell(participant)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantLocationTableViewCellIdentifier, for: indexPath) as? ParticipantLocationTableViewCell {
                cell.configureCell(participant)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
