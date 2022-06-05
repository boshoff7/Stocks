//
//  UILoadAnimation.swift
//  Stocks
//
//  Created by Chris Boshoff on 2022/06/03.
//

import Foundation
import MBProgressHUD

/// Only implentable on a UIViewController
protocol UILoadAnimation where Self: UIViewController {
    func showLoadingAnimation()
    func hideLoadingAnimation()
}

extension UILoadAnimation {
    
    func showLoadingAnimation() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    func hideLoadingAnimation() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
