//
//  TrackingDetailsViewController.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 15/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import AEAccordion
struct Stages:Decodable{
    var db_status:String!
    var db_data:[Stagedata]
}
struct Stagedata:Decodable{
    var JobStages:[Job_Data]
    var Job_ID:String!
    var FRT_CLR:String!
    var Line_Name:String!
    var FPOD:String!
    var POD:String!
    var POL:String!
    var INCO:String!
    var SST_name:String!
    //    var JobType:String!
    //    var JobID:String!
}

struct Job_Data:Decodable {
    var MSD_Name:String!
    var MSD_Status:String!
    var SubStages:[SubStages]
}
struct SubStages:Decodable{
    var SD_Name:String!
    var Remark:String!
    var RemarkDate:String!
    var SD_Status:String!
}

class TrackingDetailsViewController:UIViewController,ShowAlertView{
    @IBOutlet weak var cancel: UIButton!
    var jobStages = [Job_Data]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    var subStages = [SubStages]()
    
    let app = AppColor()
    let loader = AppLoader()
    
    var Port_Info:String?
    var OA_Coloader_Courier:String?
    var SL_AL:String?
    var FRT_CLR:String!
    var INCO:String?
    var SST_name:String!
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
    @IBOutlet weak var INCOLbl:UILabel!
    @IBOutlet weak var FRT_CLRImageView:UIImageView!
    @IBOutlet weak var Ship_Air:UIImageView!
    @IBOutlet weak var FRT_CLRLBL:UILabel!
    
    var stagedData = [Job_Data]()
    var tempData1 = [SubStages]()
    var tempData2 = [SubStages]()
    //    let app = AppColor()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("subStages:\(subStages)")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 80
        self.title = "Stages"
        getStages()
    }
    func getStages(){
        let loader = AppLoader()
        loader.show();
        let api = APIConstant()
        let url = api.developemntURL + "sp_MA_GetJobStages"
        let kUserDefault = UserDefaults.standard
        let auth_token = "auth_token=\(kUserDefault.value(forKey: "auth_token")!)"
        let param = "JobID=\(JOBID!)&\(auth_token)"
        print(url,param)
        DataManager.getJSONFromURL(url, param:param, completion: { (data, error) in
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(Stages.self, from: data!)
                print(json)
                for i in json.db_data{
                    self.stagedData = i.JobStages
                    print( self.stagedData.count)
                    for j in i.JobStages{
                        self.tempData1 = j.SubStages
                    }
                    DispatchQueue.main.async {
                        self.PODlbl.text = "POD :\(i.FPOD!)"
                        self.POLlblL.text = "POL :\(i.POL!)"
                        self.SL_ALlbl.text = i.Line_Name
                        self.INCOLbl.text = "INCO : \(i.INCO!)"
                        self.view.backgroundColor = loader.bg
                        if i.FRT_CLR == "FRT"{
                            self.FRT_CLRImageView.image = UIImage(named:"project_cargo-icon")
                            self.FRT_CLRImageView.tintColor = self.app.hexStringToUIColor(hex: "4C7FFF")
                            self.FRT_CLRLBL.text = i.FRT_CLR
                        }
                        else if i.FRT_CLR == "CLR"{
                            self.FRT_CLRImageView.image = UIImage(named:"custom_icon")
                            self.FRT_CLRImageView.tintColor = self.app.hexStringToUIColor(hex: "4C7FFF")
                            self.FRT_CLRLBL.text = i.FRT_CLR
                        }
                        if i.SST_name == "Air-Cargo"{
                            self.Ship_Air.image = UIImage(named:"air-transport")
                        }
                        else{
                            self.Ship_Air.image = UIImage(named:"ocean-transportation")
                            
                        }
                    }
                    
                    
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
                    self.showAlert(message:json.db_status)
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
        var numOfSection: NSInteger = 0
        if stagedData.count > 0   {
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
        return self.stagedData.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StagesCell
        let data  =  self.stagedData[indexPath.row]
        
        if data.MSD_Status == "No"{
            cell.notificationView.backgroundColor = UIColor.red
            cell.notificationBackgroundView.backgroundColor = UIColor.red
            
        }else{
            cell.notificationView.backgroundColor = app.hexStringToUIColor(hex: "26AE88")
            cell.notificationBackgroundView.backgroundColor = app.hexStringToUIColor(hex: "26AE88")
            
            
        }
        
        cell.a1.text = data.MSD_Name
        cell.a2.text = data.MSD_Status
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data  = stagedData[indexPath.row]
        self.tempData1 = data.SubStages
        self.tempData2 = tempData1
        print(self.tempData2)
        print("self.tempData2.count:\(self.tempData2.count)")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "Remarks", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Remarks" {
            let nextScene =  segue.destination as! RemarksViewController
            nextScene.subStages = self.tempData2
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}


