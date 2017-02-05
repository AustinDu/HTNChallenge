//
//  ParticipantLocationTableViewCell.swift
//  HTNChallenge
//
//  Created by Austin Du on 2017-02-04.
//  Copyright © 2017 Austin Du. All rights reserved.
//

import UIKit
import MapKit

class ParticipantLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var mapkit: MKMapView!
    
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
            if let lat = participant.latitude, let lng = participant.longitude, let latD = Double(lat), let lngD = Double(lng) {
                print("\(latD) \(lngD)")
                let location = CLLocationCoordinate2D(
                    latitude: latD,
                    longitude: lngD
                )
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegion(center: location, span: span)
                self.mapkit.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = participant.name
                self.mapkit.addAnnotation(annotation)
            }
        }
    }
}
