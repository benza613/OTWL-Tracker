//
//  TrackingDetailsViewController.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 15/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit

struct Stages:Decodable{
    var db_status:String!
    var db_data:[Stagedata]
}
struct Stagedata:Decodable{
    var Job_ID:String!
    var JobStages:[Job_Data]
}

struct Job_Data:Decodable {
    var MSD_Name:String!
    var MSD_Status:String!
    //    var subStages:[SubStages]
}
struct SubStages:Decodable{
    var SD_Name:String!
    var Remark:String!
    var RemarkDate:String!
    var SD_Status:String!
}

class TrackingDetailsViewController: UIViewController {
    @IBOutlet weak var cancel: UIButton!
    var jobStages = [Job_Data]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    
    let app = AppColor()
    let loader = AppLoader()
    
    var Port_Info:String?
    var OA_Coloader_Courier:String?
    var SL_AL:String?
    var Customer:String?
    
    var POL:String!
    var POD:String!
    var POL_Time:String!
    var POD_Time:String!
    var JOBID:String!
    @IBOutlet weak var Port_Infolbl: UILabel!
    @IBOutlet weak var OA_Coloader_Courierlbl: UILabel!
    @IBOutlet weak var SL_ALlbl: UILabel!
    @IBOutlet weak var Customerlbl: UILabel!
    
    @IBOutlet weak var POLlblL:UILabel!
    @IBOutlet weak var PODlbl:UILabel!
    @IBOutlet weak var POL_Timelbl:UILabel!
    @IBOutlet weak var POD_Timelbl:UILabel!
    var stagedData = [Job_Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(jobStages)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 80
        //        let newString = Port_Info!.replacingOccurrences(of:"</br>", with: " ")
        //        self.Port_Infolbl.text = "Port_Info : \(newString)"
        //        self.OA_Coloader_Courierlbl.text = "Courier : \(OA_Coloader_Courier!)"
        //        self.SL_ALlbl.text = "Shipping/Air: \(SL_AL!)"
        //        self.Customerlbl.text =
        
        //        self.PODlbl.text = POD
        //        self.POLlblL.text = POL
        //        self.POD_Timelbl.text = POD_Time
        //        self.POL_Timelbl.text = POD_Time
        getStages()
    }
    
    func getStages(){
        let loader = AppLoader()
        loader.show();
        let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/sp_MA_GetJobStages/"
        print(url)
        DataManager.getJSONFromURL(url, param:JOBID, completion: { (data, error) in
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(Stages.self, from: data!)
                for i in json.db_data{
                    self.stagedData = i.JobStages
                    print( self.stagedData.count)
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    loader.dismiss()
                }
                if json.db_status == "true"{
                    DispatchQueue.main.async {
                        loader.dismiss()
                    }
                }else{
                    //                    self.showAlert(message:json.db_msg)
                    loader.dismiss()
                }
            }catch{
                print(error.localizedDescription)
                loader.dismiss()
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TrackingDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stagedData.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StagesCell
        let data  =  self.stagedData[indexPath.row]
        cell.a1.text = data.MSD_Name
        cell.a2.text = data.MSD_Status
        return cell
    }
}
