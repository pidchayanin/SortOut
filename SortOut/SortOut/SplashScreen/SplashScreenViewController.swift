//
//  SplashScreenViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 25/5/2564 BE.
//

import UIKit
import SwiftyGif
import HandySwift

class SplashScreenViewController: UIViewController {
    
    let logoAnimationView = LogoAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
        delay(by: .seconds(5)) {
            self.showView()
        }
    }
    
    
    
    
    func showView() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabbarID")
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }

}
extension SplashScreenViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}
