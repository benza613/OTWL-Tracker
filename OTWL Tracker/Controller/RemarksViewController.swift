//
//  RemarksViewController.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 28/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit

class RemarksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var subStages = [SubStages]()
    let app = AppColor()
    let loader = AppLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.backgroundColor = loader.bg
        self.title = "Sub Stages"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
}
extension RemarksViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        if subStages.count > 0   {
            self.tableView.backgroundView = nil
            numOfSection = 1
        }
        else
        {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x:0, y:0, width:self.tableView.bounds.size.width, height:self.tableView.bounds.size.height))
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = noDataLabel
        }
        return numOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subStages.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StagesCell
        let data  =  self.subStages[indexPath.row]
        cell.Remark.text = "Remark :\(data.Remark!)"
        cell.RemarkDate.text = "Date :\(data.RemarkDate!)"
        cell.SD_Name.text = "Substage :\(data.SD_Name!)"
        return cell
    }
}
