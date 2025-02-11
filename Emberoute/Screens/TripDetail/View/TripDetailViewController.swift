//
//  TripDetailViewController.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 08.02.25.
//

import UIKit
import MapKit
import Combine

final class TripDetailViewController: UIViewController {
    private let viewModel: TripDetailViewModel
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wifiImageView: UIView!
    @IBOutlet weak var toiletImageView: UIView!
    @IBOutlet weak var wheelchairImageView: UIView!
    @IBOutlet weak var bicycleImageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    required init?(coder: NSCoder, viewModel: TripDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        setupUI()
        viewModel.onViewDidLoad()
    }
    
    @IBAction func didTapSeeRoute(_ sender: UIButton) {
        navigateToRouteList()
    }
}

extension TripDetailViewController: MKMapViewDelegate {
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

private extension TripDetailViewController {
    func setupUI() {
        title = viewModel.title
        backgroundCardView.cardView()
    }
    
    func setUpViewModel() {
        viewModel.onStateChange.sink { state in
            self.update(state: state)
        }.store(in: &cancellable)
    }
    
    func update(state: TripDetailViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch state {
            case let .update(detail):
                configure(detail)
            }
        }
    }
    
    func configure(_ detail: TripDetailViewData) {
        mapView.delegate = self
        
        let coordinates = detail.zone
        let polygon = MKPolygon(
            coordinates: coordinates,
            count: coordinates.count
        )
        mapView.addOverlay(polygon)
        zoomToPolygon(polygon)

        descriptionLabel.attributedText = detail.description
        toiletImageView.isHidden = !detail.hasToilet
        wheelchairImageView.isHidden = !detail.hasWheelchair
        wifiImageView.isHidden = !detail.hasWifi
        bicycleImageView.isHidden = !detail.hasBicycle
    }
    
    func zoomToPolygon(_ polygon: MKPolygon) {
        var mapRect = polygon.boundingMapRect
        let scaleFactor: Double = 1
        mapRect = mapRect.insetBy(dx: -mapRect.size.width * (scaleFactor - 1) / 2,
                                  dy: -mapRect.size.height * (scaleFactor - 1) / 2)

        let edgePadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
    }
    
    func navigateToRouteList() {
        let viewController: TripRouteListViewController? = .instantiate { [weak self] coder in
            guard let self else { return nil }
            return TripRouteListViewController(
                coder: coder,
                viewModel: TripRouteListViewModelImpl(tripUID: viewModel.tripUID)
            )
        }
        guard let viewController = viewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
