//
//  ParticipantDetailedInfoTableViewCell.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit

class ParticipantDetailedInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var skills: UIStackView!
    @IBOutlet weak var skillsStackHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ participant: Participant?) {
        self.selectionStyle = .none
        if let participant = participant {
            self.profilePic.contentMode = .scaleAspectFill
            self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
            self.profilePic.layer.masksToBounds = true
            
            self.name.text = participant.name
            self.phone.text = participant.phone
            self.company.text = participant.company
            self.email.text = participant.email
            
            if let picture = participant.picture {
                let url = URL(string: picture)
                self.profilePic.kf.setImage(with: url)
            }
            self.skillsStackHeightConstraint.constant = CGFloat(participant.skills.count) * 25.0
            
            for i in 0..<participant.skills.count {
                let skillView = ParticipantSkillView()
                skillView.configureView(participant.skills[i].0, level: participant.skills[i].1, showBullet: false)
                self.skills.addArrangedSubview(skillView)
            }
        }
    }
    
}
