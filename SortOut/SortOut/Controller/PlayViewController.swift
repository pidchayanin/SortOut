//
//  PlayViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 25/2/2564 BE.
//

import UIKit

private func firstDayOfMonth(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components)!
}

class PlayViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historyView: UIView!
    
    let cellReuseIdentifier = "historyCell"
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var historyCD: [HistoryCD] = []
    
    var sections = [HistorySection<Date, HistoryCD>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        historyView.layer.cornerRadius = 10
        
        fetchData()
        
        self.sections = HistorySection.group(rows: self.historyCD, by: { firstDayOfMonth(date: $0.date!) })
        self.sections.sort { lhs, rhs in lhs.sectionItem > rhs.sectionItem }
    }
    
    func fetchData() {
        do {
            self.historyCD = try context?.fetch(HistoryCD.fetchRequest()) as! [HistoryCD]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("context fetch")
            print("=============")
        }
        catch {
            print("fetch error: ", error)
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

extension PlayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let historySection = sections[section]
        return historySection.rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionn = self.sections[section]
        let date = sectionn.sectionItem
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PlayTableViewCell
        
        var historySection = self.sections[indexPath.section]
        let displayItems = historySection.rows[indexPath.row]
        let date = displayItems.date
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date!)
        
        print("eng sen: ", displayItems.englishSentence ?? "")
        print("=======")
        print("thai sen: ", displayItems.thaiSentence ?? "")
        print("=======")
        print("star sen: ", displayItems.receivedStar ?? "")
        print("=======")
        
        cell.engSentenceLabel.text = displayItems.englishSentence ?? ""
        
        cell.thSentenceLabel.text = displayItems.thaiSentence ?? ""
        
        cell.starImage.image = UIImage(named: (displayItems.receivedStar ?? ""))
        
        historySection.rows.sort { _,_ in minutes > minutes }
        
        return cell
    }
    
    
}
