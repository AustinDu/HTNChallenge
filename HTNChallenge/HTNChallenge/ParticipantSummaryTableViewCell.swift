//
//  ParticipantSummaryTableViewCell.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit
import Kingfisher

class ParticipantSummaryTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skillsStack: UIStackView!
    
    // MARK: Properties
    var skillViews: [UIView] = []
    var currentSkillsWidth: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ participant: Participant) {
        self.selectionStyle = .none
        
        for skillView in skillViews {
            self.skillsStack.removeArrangedSubview(skillView)
            skillView.removeFromSuperview()
        }
        self.currentSkillsWidth = 0
        
        self.profilePic.contentMode = .scaleAspectFill
        self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
        self.profilePic.layer.masksToBounds = true
        
        self.nameLabel.text = participant.name
        if let picture = participant.picture {
            let url = URL(string: picture)
            self.profilePic.kf.setImage(with: url)
        }
        for i in 0..<participant.skills.count {
            let skillView = ParticipantSkillView()
            skillView.configureView(participant.skills[i].0, level: participant.skills[i].1, showBullet: i == participant.skills.count-1 ? false : true)
            
            let nextWidth = skillView.skillName.intrinsicContentSize.width + 52 // 52 = 8 (spacing) + 20 (skill level) + 8 (spacing) + 8 (bullet) + 8 (spacing)
            if self.currentSkillsWidth + nextWidth > skillsStack.frame.width {
                if skillViews.count > 0 {
                    (skillViews[skillViews.count-1] as? ParticipantSkillView)?.bulletLabel.text = "..."
                }
                break
            } else {
                self.skillViews.append(skillView)
                self.skillsStack.addArrangedSubview(skillView)
                self.currentSkillsWidth += nextWidth
            }
        }
        let fillerView = UIView()
        self.skillViews.append(fillerView)
        self.skillsStack.addArrangedSubview(fillerView)
    }

}
