//
//  TripRouteTableViewCell.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import UIKit
import MapKit

final class TripRouteTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var departureLocationLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.delegate = self
        backgroundCardView.cardView()
    }
    
    func configure(_ model: TripRouteDetailViewData) {
        let coordinates = model.zone
        let polygon = MKPolygon(
            coordinates: coordinates,
            count: coordinates.count
        )
        mapView.addOverlay(polygon)
        zoomToPolygon(polygon)
        
        departureLocationLabel.text = model.departureName
        departureTimeLabel.text = model.departureTime
        arrivalTimeLabel.text = model.arrivalTime
    }
    
    
    func zoomToPolygon(_ polygon: MKPolygon) {
        var mapRect = polygon.boundingMapRect
        let scaleFactor: Double = 0.5
        mapRect = mapRect.insetBy(dx: -mapRect.size.width * (scaleFactor - 1) / 2,
                                  dy: -mapRect.size.height * (scaleFactor - 1) / 2)

        let edgePadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
    }
}

extension TripRouteTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        if let polygonOverlay = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygonOverlay)
            renderer.fillColor = UIColor.theme.withAlphaComponent(0.3) // Fill color
            renderer.strokeColor = UIColor.theme
            renderer.lineWidth = 1
            return renderer
        }
        return MKOverlayRenderer()
    }
}
