//
//  GameSettingPopUpViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 21/2/2564 BE.
//

import UIKit
import AVFoundation

class GameSettingPopUpViewController: UIViewController {

    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var quitView: UIView!
    @IBOutlet weak var soundBtn: UIButton!
    @IBOutlet weak var soundImg: UIImageView!
    
    var mute = true
    
    let muteImg = UIImage(named: "sound-off")
    let unmuteImg = UIImage(named: "sound-on")
    
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
            
            DataManager.shared.gameVc.AudioPlayer.stop()
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabbarID") as! TabbarViewController
            self.present(vc, animated: true, completion: nil)
            
            
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
      }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func muteOrUnMutetapped(_ sender: Any) {
        
        switch mute {
        case true:
            soundBtn.setTitle("                Sound: Off", for: .normal)
            
            UserDefaults.standard.setValue(true, forKey: "muteBool")
            soundImg.image = muteImg
            DataManager.shared.gameVc.AudioPlayer.pause()
            DataManager.shared.gameVc.AudioPlayer2.volume = 0
            mute = false
            print("pause")
        case false:
            soundBtn.setTitle("                Sound: On", for: .normal)
            
            UserDefaults.standard.setValue(false, forKey: "muteBool")
            soundImg.image = unmuteImg
            DataManager.shared.gameVc.AudioPlayer.play()
            DataManager.shared.gameVc.AudioPlayer2.volume = 1
            mute = true
            print("play")
        }
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
