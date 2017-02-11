//
//  FilterSkillCategoryTableViewCell.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-10.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit
import M13Checkbox

class FilterSkillCategoryTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet var checkbox: M13Checkbox!
    @IBOutlet weak var skillLabel: UILabel!
    
    // MARK: Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(skill: String, isChecked: Bool) {
        self.selectionStyle = .none
        self.skillLabel.text = skill
        self.checkbox.isEnabled = false
        self.checkbox.setCheckState(isChecked ? .checked : .unchecked, animated: false)
    }
    
    func toggleCheckbox() {
        self.checkbox.toggleCheckState(false)
    }
    
}
