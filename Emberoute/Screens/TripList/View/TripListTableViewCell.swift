//
//  TripListViewCell.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import UIKit

final class TripListTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var departureLocationLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalLocationLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCardView.cardView()
    }
    
    func configure(_ model: TripListViewData) {
        departureLocationLabel.text = model.departureName
        departureTimeLabel.text = model.departureTime
        
        arrivalLocationLabel.text = model.arrivalName
        arrivalTimeLabel.text = model.arrivalTime
    }
}
