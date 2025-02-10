//
//  TripListViewController.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 07.02.25.
//

import UIKit
import Combine

final class TripListViewController: UITableViewController {
    private let viewModel = TripListViewModelImpl()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        setupUI()
        viewModel.onViewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripListTableViewCell.className, for: indexPath) as! TripListTableViewCell
        let trip = viewModel.itemFor(rowAt: indexPath.item)
        cell.configure(trip)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.itemFor(rowAt: indexPath.item)
        let viewController = TripDetailViewController.instantiate { coder in
            TripDetailViewController(
                coder: coder,
                viewModel: TripDetailViewModelImpl(input: item.detail)
            )
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension TripListViewController {
    func setupUI() {
        title = viewModel.title
    }
    
    func setUpViewModel() {
        viewModel.onStateChange.sink { state in
            self.update(state: state)
        }.store(in: &cancellable)
    }

    func update(state: TripListViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .loading:
                showLoadingIndicator()
            case .finished:
                hideLoadingIndicator()
                tableView.reloadData()
            case let .snackBar(message, state):
                hideLoadingIndicator()
                showSnackBar(with: message, state: state)
            }
        }
    }
}
