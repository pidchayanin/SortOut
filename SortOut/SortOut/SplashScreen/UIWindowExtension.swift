//
//  UIWindowExtension.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 25/5/2564 BE.
//

import UIKit

extension UIWindow {
    
    static var mainWindow: UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
    
    func fadeInViewChanges(viewChanges:() -> (Void)) {

        // snapshot current window
        let snapshot = self.snapshotView(afterScreenUpdates: false)
        self.addSubview(snapshot!)
        
        // make underneath changes
        viewChanges()
        
        // fade out snapshot
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseInOut, animations: {
            snapshot!.alpha = 0.0;
        }, completion: { finished in
            snapshot!.removeFromSuperview()
        })
    }
    
}
