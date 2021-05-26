//
//  TabbarViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 23/1/2564 BE.
//

import UIKit
import TransitionableTab

class TabbarViewController: UITabBarController {

    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.selectedIndex = 2;
        //tabbar.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

}

extension TabbarViewController: TransitionableTab {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
}
