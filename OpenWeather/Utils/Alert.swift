//
//  Alert.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import UIKit

class Alert: NSObject {
    // MARK: - Show error message for settings authorisation
    static func showAlert(withMsg title: String = "Oops!", message: String) {
        UIAlertController.showAlert(title, message: message, buttons: [AlertConstant.alertOK], completion: { (_, index) in
        })
    }
}

extension UIAlertController {
    // Shows alert view with completion block
    class func showAlert(_ title: String, message: String, buttons: [String], isText: Bool = false, completion: ((UIAlertController, Int) -> Void)?) {
        let alertView: UIAlertController? = self.init(title: title, message: message, preferredStyle: .alert)
        if isText {
            alertView!.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = AlertConstant.alertTextfield
            }
        }
        for i in 0..<buttons.count {
            alertView?.addAction(UIAlertAction(title: buttons[i], style: .default, handler: {(_ action: UIAlertAction) -> Void in
                if completion != nil {
                    completion!(alertView!, i)
                }
            }))
        }
        if #available(iOS 13.0, *) {
            UIApplication.scene.present(alertView!, animated: true, completion: nil)
        } else {
            UIApplication.visibleViewController.present(alertView!, animated: true, completion: nil)
        }
    }
}
