//
//  GameSettingPopUpViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 21/2/2564 BE.
//

import UIKit

class GameSettingPopUpViewController: UIViewController {

    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var quitView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.settingView.layer.cornerRadius = 20
        self.quitView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CloseGamePopUp(_ sender: Any) {
        //self.view.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func HomeGamePopUp(_ sender: Any) {
        let alert = UIAlertController(title: "Back to Home", message: "Are you sure?", preferredStyle: .alert)
       
        //YES
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"YES\" alert occured.")
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabbarID") as! TabbarViewController
            self.present(vc, animated: true, completion: nil)
            
            
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
      }))
    
        self.present(alert, animated: true, completion: nil)
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
