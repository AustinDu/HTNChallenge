//
//  ParticipantListViewController.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit

class ParticipantListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var participants: [Participant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        NetworkManager.shared.getParticipants { (result) in
            self.participants = result
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Hack the North"
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantSummaryTableViewCellIdentifier, for: indexPath) as? ParticipantSummaryTableViewCell {
            cell.configureCell(participants[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let detailedVC = storyBoard.instantiateViewController(withIdentifier: ParticipantDetailsViewControllerIdentifier) as? ParticipantDetailsViewController {
            detailedVC.participant = self.participants[indexPath.row]
            self.navigationItem.title = "All Users"
            self.navigationController?.pushViewController(detailedVC, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.participants.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
