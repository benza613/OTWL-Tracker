////
////  SampleTableViewController.swift
////  AEAccordionExample
////
////  Created by Marko Tadic on 6/26/15.
////  Copyright © 2015 AE. All rights reserved.
////
//
//import AEAccordion
//struct Stages:Decodable{
//    var db_status:String!
//    var db_data:[Stagedata]
//}
//struct Stagedata:Decodable{
//    var Job_ID:String!
//    var JobStages:[Job_Data]
//}
//
//struct Job_Data:Decodable {
//    var MSD_Name:String!
//    var MSD_Status:String!
//    var SubStages:[SubStages]
//}
//struct SubStages:Decodable{
//    var SD_Name:String!
//    var Remark:String!
//    var RemarkDate:String!
//    var SD_Status:String!
//}
//final class SampleTableViewController: AccordionTableViewController {
//    
//    // MARK: Properties
//    var jobStages = [Job_Data]()
//    var stagedData = [Job_Data]()
//    var subStages = [SubStages]()
//
//    let app = AppColor()
//    
//    var JOBID:String!
//    private let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
//    // MARK: Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getStages()
//        registerCell()
//        expandFirstCell()
//    }
//    func getStages(){
//        let loader = AppLoader()
//        loader.show();
//        let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/sp_MA_GetJobStages/"
//        print(url)
//        DataManager.getJSONFromURL(url, param:JOBID, completion: { (data, error) in
//            let decoder = JSONDecoder()
//            do {
//                let json = try decoder.decode(Stages.self, from: data!)
//                for i in json.db_data{
//                    self.stagedData = i.JobStages
//                    print( self.stagedData.count)
//                    for i in self.stagedData{
//                        self.subStages = i.SubStages
//                    }
//                    
//                }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    loader.dismiss()
//                }
//                if json.db_status == "true"{
//                    DispatchQueue.main.async {
//                        loader.dismiss()
//                    }
//                }else{
//                    //                    self.showAlert(message:json.db_msg)
//                    loader.dismiss()
//                }
//            }catch{
//                print(error.localizedDescription)
//                loader.dismiss()
//            }
//        })
//        
//    }
//    // MARK: Helpers
//    
//    func registerCell() {
//        let cellNib = UINib(nibName: SampleTableViewCell.reuseIdentifier, bundle: nil)
//        tableView.register(cellNib, forCellReuseIdentifier: SampleTableViewCell.reuseIdentifier)
//    }
//    
//    func expandFirstCell() {
//        let firstCellIndexPath = IndexPath(row: 0, section: 0)
//        expandedIndexPaths.append(firstCellIndexPath)
//    }
//    
//    // MARK: UITableViewDataSource
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.stagedData.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: SampleTableViewCell.reuseIdentifier, for: indexPath)
//        if let cell = cell as? SampleTableViewCell {
//            
//            if self.stagedData[indexPath.row].MSD_Status == "No" {
//                cell.headerView.backgroundColor = UIColor.red
//            }else{
//                cell.headerView.backgroundColor = app.hexStringToUIColor(hex: "26AE88")
//                
//            }
//            cell.day.text = self.stagedData[indexPath.row].MSD_Name
//            
//            //            cell.weatherIcon.image = UIImage(named: "0\(indexPath.row + 1)")
////            cell.SD_Name.text = self.stagedData[indexPath.row].subStages[indexPath.row].SD_Name
////            cell.Remark.text = self.stagedData[indexPath.row].subStages[indexPath.row].Remark
////            cell.RemarkDate.text = self.stagedData[indexPath.row].subStages[indexPath.row].RemarkDate
////            cell.SD_Status.text = self.stagedData[indexPath.row].subStages[indexPath.row].SD_Status
//        }
//        return cell
//    }
//    
//    // MARK: UITableViewDelegate
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return expandedIndexPaths.contains(indexPath) ? 200.0 : 50.0
//    }
// 
//}

