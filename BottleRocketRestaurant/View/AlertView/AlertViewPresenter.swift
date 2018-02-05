//
//  AlertViewPresenter.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

final class AlertViewPresenter: UserInterfaceCheckable {
    static let shared = AlertViewPresenter()
    weak var delegate: AlertViewPresenterDelegate?
    
    private init() {}
}


// MARK: - Present submit Alert
extension AlertViewPresenter {
    
    func presentSubmit(in viewController: UIViewController, title: String, message: String, textFieldConfiguration: ((UITextField) -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField(configurationHandler: textFieldConfiguration)
        
        let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            guard let textField = alert.textFields?.first, textField.text?.isEmpty == false else { return }
            self.delegate?.alertView(self, didSubmit: textField.text!)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(submitAction)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}


// MARK: - Present Error Alert
extension AlertViewPresenter {
    
    func presentError(withMessage msg: String, animated: Bool = true, completion: (() -> Void)? = nil) {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1
        alertWindow.makeKeyAndVisible()
        
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        alertWindow.rootViewController?.present(alert, animated: animated, completion: completion)
    }
    
}


// MARK: - Present Popup Alert
extension AlertViewPresenter {
    
    func presentPopup(in viewController: UIViewController, title: String?, message: String?, actionTitles: [String] = ["OK"], actions: [((UIAlertAction) -> ())?] = [nil]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
}


// MARK: - Present Action Sheet Alert
extension AlertViewPresenter {
    
    func presentActionSheet(in viewController: UIViewController, title: String?, message: String?, actionTitles: [String], actions: [((UIAlertAction) -> ())?] = [nil]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        
        if isPad {
            let callingViewFrame = viewController.view.frame
            let xPos = callingViewFrame.size.width / 2
            let yPos = callingViewFrame.size.height - 50
            alert.popoverPresentationController?.sourceView = viewController.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: xPos, y: yPos, width: 1, height: 1)
            alert.popoverPresentationController?.permittedArrowDirections = .down
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}

//actionSheet
