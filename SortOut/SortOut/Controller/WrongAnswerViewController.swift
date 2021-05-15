//
//  WrongAnswerViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 16/5/2564 BE.
//

import UIKit

class WrongAnswerViewController: UIViewController {
    
    @IBOutlet weak var complimentLabel: UILabel!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var engSentenceLabel: UILabel!
    @IBOutlet weak var thaiSentenceLabel: UILabel!
    
    var compliments = ""
    var receiveStar = ""
    var receiveEngSentence = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        engSentenceLabel.text = receiveEngSentence
        starImg.image = UIImage(named: receiveStar)
        complimentLabel.text = compliments
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
