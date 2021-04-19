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
    
    @IBAction func backTapped(_ sender: Any) {
        isReload = true
    }
    //    @IBAction func addToListTapped(_ sender: UIButton) {
//        switch sender.tag {
//                    case 0:
//                        print("Button 1 Clicked")
//                    case 1:
//                        let vocabTab = (self.tabBarController?.viewControllers?[3]) as? VocabListViewController
//                        performSegue(withIdentifier: "addToVocabList", sender: self)
//                        
//                        //print(vocabTab?.words)
//                    default: break
//              }
//    }
    

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

        //cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if word[indexPath.row] != "" {
            cell.wordLabel.text = word[indexPath.row]
        }
        
        
        cell.addToVocabListButtonAction = { [unowned self] in
            let alert = UIAlertController(title: "Add this word to list", message: "Are you sure?", preferredStyle: .alert)
           
            //YES
            alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            //NSLog("The \"YES\" alert occured.")
                
                if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
//                let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabbarID") as! TabbarViewController
//                if let destVC = vc.viewControllers,
//                   let nc = destVC.first as? UINavigationController,
//                   let vocabVC = nc.topViewController as? VocabListViewController{
//                    vocabVC.words.append(word[indexPath.row])
//                }
//                let destVC = vc.viewControllers?[3] as! VocabListViewController
//                destVC.words.append(word[indexPath.row])
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "NCID") as! UINavigationController
                //let destVC = vc.topViewController as! VocabListViewController
                //destVC.words.append(word[indexPath.row])
                //print(destVC.words)
                //self.present(vc, animated: true, completion: nil)
                    let addWord = AddToVocabCD(context:context)
                    let addedWord = word[indexPath.row]
                    addWord.addedWord = addedWord
                    print("added word: ", addWord.addedWord!)
                    
                    
                    cell.addToVocabListButton.isEnabled = false
                    cell.addToVocabListButton.backgroundColor = .lightGray
                    
                    cell.addToListLabel.isHidden = true
                    
                    cell.undoButton.isHidden = false
                    cell.undoButton.isEnabled = true
                    
                    cell.addedTextLabel.isHidden = false
                    
                    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                    
                }
                
            }))
            
            //NO
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Tap no")
          }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
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
