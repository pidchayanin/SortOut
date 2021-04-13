//
//  DictionaryViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 13/4/2564 BE.
//

import UIKit

class DictionaryViewController: UIViewController {
    
    @IBOutlet weak var dictionaryTableView: UITableView!
    
    let cellReuseIdentifier = "dictCell"
    let cellSpacingHeight: CGFloat = 20
    var word = [""]
    let words = ["i", "too", "i", "here"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dictionaryTableView.delegate = self
        dictionaryTableView.dataSource = self
        
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

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DictionaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DictionaryTableViewCell

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.wordLabel.text = word[indexPath.row]
        
        
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        
        cell.clipsToBounds = true
        
        
        
        //fetchItem()
        //tableView.reloadData()
        return cell
    }
    
    
    
}
