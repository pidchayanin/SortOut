//
//  TutorialViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 26/5/2564 BE.
//

import UIKit
import HandySwift

class TutorialViewController: UIViewController {

    @IBOutlet weak var firstTutorialImg: UIImageView!
    @IBOutlet weak var goNextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstTutorialImg.image = UIImage(named: "tutorial-1.jpg")
        
        self.goNextBtn.isHidden = true
        
        delay(by: .seconds(1.5)) {
            self.goNextBtn.isHidden = false
            self.goNextBtn.isEnabled = true
        }
        
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabbarID")
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
