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
    let skillsToColour: [String: UIColor] = [
        "JS": UIColor(red: 240/255.0, green: 219/255.0, blue: 79/255.0, alpha: 1.0),
        "C": UIColor(red: 0/255.0, green: 152/255.0, blue: 229/255.0, alpha: 1.0),
        "Go": UIColor(red: 116/255.0, green: 206/255.0, blue: 221/255.0, alpha: 1.0),
        "Angular": UIColor(red: 221/255.0, green: 3/255.0, blue: 48/255.0, alpha: 1.0),
        "C++": UIColor(red: 0/255.0, green: 68/255.0, blue: 129/255.0, alpha: 1.0),
        "HTML/CSS": UIColor(red: 228/255.0, green: 77/255.0, blue: 38/255.0, alpha: 1.0),
        "Java": UIColor(red: 47/255.0, green: 109/255.0, blue: 184/255.0, alpha: 1.0),
        "iOS": UIColor(red: 255/255.0, green: 67/255.0, blue: 42/255.0, alpha: 1.0),
        "Public Speaking": UIColor(red: 168/255.0, green: 177/255.0, blue: 92/255.0, alpha: 1.0),
        "Product Design": UIColor(red: 253/255.0, green: 197/255.0, blue: 60/255.0, alpha: 1.0),
        "NodeJS": UIColor(red: 144/255.0, green: 197/255.0, blue: 63/255.0, alpha: 1.0),
        "Android": UIColor(red: 153/255.0, green: 204/255.0, blue: 0/255.0, alpha: 1.0)
    ]
    
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
