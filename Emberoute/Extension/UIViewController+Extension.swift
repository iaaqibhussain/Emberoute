//
//  UIViewController+Extension.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 09.02.25.
//

import UIKit

// MARK: - Activity Indicator
extension UIViewController {
    private static var loadingView: UIView?

    func showLoadingIndicator(
        style: UIActivityIndicatorView.Style = .large,
        backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    ) {
        guard UIViewController.loadingView == nil else { return }

        let loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = backgroundColor

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = .white
        activityIndicator.startAnimating()

        loadingView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])

        DispatchQueue.main.async {
            self.view.addSubview(loadingView)
        }

        UIViewController.loadingView = loadingView
    }

    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            UIViewController.loadingView?.removeFromSuperview()
            UIViewController.loadingView = nil
        }
    }
}

// MARK: - Snackbar

extension UIViewController {
    private static var errorView: UIView?

    func showSnackBar(
        with message: String,
        backgroundColor: UIColor = UIColor.red.withAlphaComponent(1),
        textColor: UIColor = .white,
        state: Bool = false
    ) {
        // Ensure only one error view is displayed at a time
        guard UIViewController.errorView == nil else { return }

        // Create the error view
        let errorView = UIView()
        errorView.backgroundColor = state ? .secondaryTheme : .red
        errorView.alpha = 0
        
        // Create the error label
        let errorLabel = UILabel()
        errorLabel.text = message
        errorLabel.textColor = textColor
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.boldSystemFont(ofSize: 16)

        // Add the error label to the error view
        errorView.addSubview(errorLabel)

        // Set AutoLayout for the error label
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -20),
            errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor)
        
        ])

        view.addSubview(errorView)

        let errorViewHeight: CGFloat = 60

        errorView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: errorViewHeight)

        UIView.animate(withDuration: 0.5, animations: {
            errorView.frame.origin.y = 0
            errorView.alpha = 1
        })

        // Keep track of the error view
        UIViewController.errorView = errorView

        // Hide the error view after 3 seconds (or any other duration)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.hideError()
        }
    }

    func hideError() {
        DispatchQueue.main.async {
              guard let errorView = UIViewController.errorView else { return }

              UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                  errorView.alpha = 0  // Fade out
                  errorView.transform = CGAffineTransform(translationX: 0, y: -20) // Slide up slightly
              }) { _ in
                  errorView.removeFromSuperview()
                  UIViewController.errorView = nil
              }
          }
    }
}

// MARK: - Storyboard Initializer

extension UIViewController {
    static func instantiate(
        fromStoryboard storyboardName: String = "Main",
        creator: ((NSCoder) -> UIViewController?)? = nil
    ) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: storyboardName, creator: creator)
    }

    private static func instantiateFromStoryboardHelper<T: UIViewController>(
        storyboardName: String,
        creator: ((NSCoder) -> UIViewController?)? = nil
    ) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = self.className// String(describing: self.cl)
        return storyboard.instantiateViewController(identifier: self.className, creator: creator) as! T
    }
}
