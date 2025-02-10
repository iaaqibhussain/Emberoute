//
//  TripRouteListViewController.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import UIKit
import Combine
import MapKit

final class TripRouteListViewController: UITableViewController {
    private let viewModel: TripRouteListViewModel
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var mapView: MKMapView!
    
    required init?(
        coder: NSCoder,
        viewModel: TripRouteListViewModel
    ) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpViewModel()
        viewModel.onViewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripRouteTableViewCell.className, for: indexPath) as! TripRouteTableViewCell
        let trip = viewModel.itemFor(rowAt: indexPath.item)
        cell.configure(trip)
        return cell
    }
}

private extension TripRouteListViewController {
    func setupUI() {
        title = viewModel.title
    }
    
    func setUpViewModel() {
        viewModel.onStateChange.sink { state in
            self.update(state: state)
        }.store(in: &cancellable)
    }
    
    func update(state: TripRouteListViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch state {
            case .loading:
                showLoadingIndicator()
            case let .setupGPSMap(coordinates):
                addPin(to: mapView, at: coordinates)
            case .finished:
                hideLoadingIndicator()
                tableView.reloadData()
            case let .error(message):
                hideLoadingIndicator()
                showSnackBar(with: message)
            }
        }
    }
    
    func addPin(
        to mapView: MKMapView,
        at coordinate: CLLocationCoordinate2D
    ) {
         let annotation = MKPointAnnotation()
         annotation.coordinate = coordinate
         mapView.addAnnotation(annotation)
         
         let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 100,
            longitudinalMeters: 100
         )
         mapView.setRegion(region, animated: true)
     }
}
