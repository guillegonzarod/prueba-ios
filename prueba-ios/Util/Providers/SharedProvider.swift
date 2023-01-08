//
//  SharedProvider.swift
//  prueba-ios
//
//  Created by Guille on 8/1/23.
//

import Foundation
import UIKit

final class SharedProvider {
    
    // MARK: - Constants
    
    /// Static instance of SharedProvider.
    static let shared = SharedProvider()
    
    // MARK: - Functions
    
    func showLoadingAlert(vc: UIViewController, message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(vc: UIViewController, title: String, message: String, lifespanSeconds: Double) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + lifespanSeconds
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }
    }
}
