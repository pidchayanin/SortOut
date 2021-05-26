//
//  FirstGameContinueViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 26/5/2564 BE.
//

import UIKit
import HandySwift

class FirstGameContinueViewController: UIViewController {
    
    @IBOutlet weak var firstGameImg: UIImageView!
    @IBOutlet weak var goNextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstGameImg.image = UIImage(named: "tutorial-3.jpg")
        
        delay(by: .seconds(1.5)) {
            self.goNextBtn.isHidden = false
            self.goNextBtn.isEnabled = true
        }
    }
    


    @IBAction func goNextTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstAnsCorrectID")
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }

}
