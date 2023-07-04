//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by 1 on 26.06.2023.
//

import UIKit

class AlertPresenter {
    private weak var presentingViewController: UIViewController?

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    func showAlert(alert result: AlertModel) {
        
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)

        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            result.completion?()
        }

        alert.view.accessibilityIdentifier = "Game results"

        alert.addAction(action)
        presentingViewController?.present(alert, animated: true)
    }
}
