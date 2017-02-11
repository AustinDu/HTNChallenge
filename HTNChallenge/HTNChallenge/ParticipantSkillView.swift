//
//  ParticipantSkillView.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit

@IBDesignable
class ParticipantSkillView: UIView {

    // MARK: IBOutlets
    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var skillLevelContainer: UIView!
    @IBOutlet weak var skillLevelLabel: UILabel!
    @IBOutlet weak var bulletLabel: UILabel!
    
    // MARK: Constants
    
    // MARK: Properties
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func configureView(_ name: String?, level: Int?, showBullet: Bool) {
        self.skillLevelContainer.layer.cornerRadius = 3.0
        if let name = name {
            self.skillName.text = name
            if let colour = skillsToColour[name] {
                self.skillLevelContainer.backgroundColor = colour
            }
        }
        if let level = level {
            self.skillLevelLabel.text = "\(level)"
        }
        if !showBullet {
            bulletLabel.isHidden = true
        }
    }
}
