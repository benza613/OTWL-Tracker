//
//  TrackingViewController.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 14/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import RealmSwift
import AEAccordion
struct Tracking:Decodable{
    var db_status:String
    //    var db_msg:String
    var db_data:[Db_data]
    
}
struct Db_data:Decodable{
    var JobType:String
    var JobID:String
    var SST_name:String
    var INCO:String
    var FPOD:String
    //    var JobStages:[JobStages]
    var Line_Name:String
    var POL:String
    var POD:String
    var FRT_CLR:String
    //    var POL_Time:String
    //    var POD_Time:String
    
    
    //    "JobID": "126",
    //    "JobType": "IMP/FRT",
    //    "SST_name": "Air-Cargo",
    //    "INCO": "EXW",
    //    "POL": "Milan,Italy",
    //    "POD": "Chennai,India",
    //    "FPOD": "Chennai,India",
    //    "Line_Name": "Emirates  Airline"
    
}
struct JobStages:Decodable{
    var a1:String
    var a2:String
}

class TrackingViewController: UIViewController,ShowAlertView,UISearchBarDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var colorrepresentation:UIView!

    let app = AppColor()
    let loader = AppLoader()
    var trackedData = [Db_data]()
    var jobStages = [JobStages]()
    var storedOffsets = [Int: CGFloat]()
    let model = generateRandomData()
    var Port_Info:String?
    var OA_Coloader_Courier:String?
    var SL_AL:String?
    var Customer:String?
    var INCO:String?
    var Line_Name:String?
    var FRT_CLR:String?
    
    var SST_name:String?
    
    var POL1:String!
    var POD2:String!
    
    var JOBID:String!
    var POL_Time1:String!
    var POD_Time1:String!
    var filtered_Data = [Db_data]()
    var searchActive : Bool = false
    var searchBar:UISearchBar!
    let screenSize = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar(frame: CGRect(x:0, y:0, width:screenSize.width - 16, height:25))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 130
        self.searchBar.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.placeholder = "Search here"
        self.view.backgroundColor = loader.bg
        tableView.keyboardDismissMode = .onDrag
        let modelName = UIDevice.current.modelName
        searchBar.returnKeyType = UIReturnKeyType.done
        self.tableView.contentInset = UIEdgeInsetsMake(66.0, 0.0, 0.0, 0.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        trackingJobs()
    }
    
    func profileUserInfo() -> ProfileModel {
        let realm = try! Realm()
        let scope = realm.objects(ProfileModel.self)
        return scope.first!
    }
    
    func trackingJobs(){
        let loader = AppLoader()
        loader.show();
        let navigationController = NavigationControllers()
        //        let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/track_data_get"
        let api = APIConstant()
        let url = api.developemntURL + "sp_MA_GetJobs"
        let userDefaultDetails = UserDefaultDetails()
        let deviceToken = userDefaultDetails.getDeviceToken()
        let kUserDefault = UserDefaults.standard
        let param = "auth_token=\(kUserDefault.value(forKey: "auth_token")!)"
        DataManager.getJSONFromURL(url, param:param, completion: { (data, error) in
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(Tracking.self, from: data!)
                //                print(json)
                //                let userDefaultDetails = UserDefaultDetails()
                if json.db_status == "true"{
                    //                    userDefaultDetails.loggedIN(isLoggedIN: true)
                    self.trackedData = json.db_data
                    DispatchQueue.main.async {
                        //                        navigationController.navigateTabbar()
                        self.tableView.reloadData()
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
}
extension TrackingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        if trackedData.count > 0   {
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
        
        if searchActive == true {
            return filtered_Data.count
        }else{
            return trackedData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TrackingCellTableViewCell
        let data  = trackedData[indexPath.row]
        if searchActive ==  true{
            if filtered_Data.count == 0{
                return cell
            }else{
                if data.SST_name == "Air-Cargo"{
                    cell.statusImage.image = UIImage(named:"air-transport")
                    cell.POL.text  = "POD :\(data.POL)"
                    cell.POD.text = "FPOD :\(data.FPOD)"
                    cell.Job_Id.text = "Air Line : \(data.Line_Name)"
                    //            cell.POD_Time.text = "\(data.JobType)"
                    cell.POL_Time.text = "INCO : \(data.INCO)"
                }
                else{
                    cell.statusImage.image = UIImage(named:"ocean-transportation")
                    cell.POL.text  = "POD :\(data.POL)"
                    cell.POD.text = "FPOD :\(data.FPOD)"
                    cell.Job_Id.text = "Shipping Line : \(data.Line_Name)"
                    //            cell.POD_Time.text = "\(data.JobType)"
                    cell.POL_Time.text = "INCO : \(data.INCO)"
                    
                }
            }
        }else{
            
            if data.SST_name == "Air-Cargo"{
                cell.statusImage.image = UIImage(named:"air-transport")
                cell.POL.text  = "POD :\(data.POL)"
                cell.POD.text = "FPOD :\(data.FPOD)"
                cell.Job_Id.text = "Air Line : \(data.Line_Name)"
                //            cell.POD_Time.text = "\(data.JobType)"
                cell.POL_Time.text = "INCO : \(data.INCO)"
                
                if data.FRT_CLR == "FRT"{
                    //cell.icon.image = UIImage(named:"project_cargo-icon")
                    cell.icon.tintColor = app.hexStringToUIColor(hex: "4C7FFF")
                    cell.Port_Info.text = data.FRT_CLR
                }
                else if data.FRT_CLR == "CLR"{
                    cell.icon.image = UIImage(named:"custom_icon")
                    cell.icon.tintColor = app.hexStringToUIColor(hex: "4C7FFF")
                    cell.Port_Info.text = data.FRT_CLR
                    
                }
                
            }
            else{
                cell.statusImage.image = UIImage(named:"ocean-transportation")
                cell.POL.text  = "POD : \(data.POL)"
                cell.POD.text = "FPOD : \(data.FPOD)"
                cell.Job_Id.text = "Shipping Line : \(data.Line_Name)"
                //            cell.POD_Time.text = "\(data.JobType)"
                cell.POL_Time.text = "INCO : \(data.INCO)"
                
                if data.FRT_CLR == "FRT"{
                    //                    cell.icon.image = UIImage(named:"project_cargo-icon")
                    cell.icon.tintColor = app.hexStringToUIColor(hex: "4C7FFF")
                    cell.Port_Info.text = data.FRT_CLR
                }
                else if data.FRT_CLR == "CLR"{
                    cell.icon.image = UIImage(named:"custom_icon")
                    cell.icon.tintColor = app.hexStringToUIColor(hex: "4C7FFF")
                    cell.Port_Info.text = data.FRT_CLR
                    
                }
                
                
            }
        }
        
        
        if data.JobType == "IMP"{
            cell.notificationBackgroundView.backgroundColor = UIColor.white
            cell.Job_Id.textColor = UIColor.black
            //            cell.POD_Time.textColor = UIColor.black
            //            cell.POL_Time.textColor = UIColor.black
            cell.POL.textColor = UIColor.black
            cell.POD.textColor = UIColor.black
            cell.statusImage.tintColor = UIColor.black
            cell.barView.backgroundColor = app.hexStringToUIColor(hex: "4C7FFF")
            cell.round1.backgroundColor = UIColor.black
            cell.round2.backgroundColor = UIColor.black
            cell.POL_Time.textColor = UIColor.black
            
        }
        else if data.JobType == "EXP"{
            cell.notificationBackgroundView.backgroundColor = UIColor.black
            cell.Job_Id.textColor = UIColor.white
            //            cell.POD_Time.textColor = UIColor.white
            //            cell.POL_Time.textColor = UIColor.white
            cell.POL.textColor = UIColor.white
            cell.POD.textColor = UIColor.white
            cell.statusImage.tintColor = UIColor.white
            cell.barView.backgroundColor = app.hexStringToUIColor(hex: "4C7FFF")
            cell.round1.backgroundColor = UIColor.white
            cell.round2.backgroundColor = UIColor.white
            cell.POL_Time.textColor = UIColor.white
            
            
        }
        else if data.JobType == "Third Country"{
            cell.notificationBackgroundView.backgroundColor = UIColor.darkGray
            cell.Job_Id.textColor = UIColor.white
            //            cell.POD_Time.textColor = UIColor.white
            //            cell.POL_Time.textColor = UIColor.white
            cell.POL.textColor = UIColor.white
            cell.POD.textColor = UIColor.white
            cell.statusImage.tintColor = UIColor.white
            cell.barView.backgroundColor = app.hexStringToUIColor(hex: "4C7FFF")
            cell.round1.backgroundColor = UIColor.white
            cell.round2.backgroundColor = UIColor.white
        }
        if data.SST_name == "Air-Cargo"{
            cell.statusImage.image = UIImage(named:"air-transport")
            cell.POL.text  = "POD :\(data.POL)"
            cell.POD.text = "FPOD :\(data.FPOD)"
            cell.Job_Id.text = "Air Line :\(data.Line_Name)"
            //            cell.POD_Time.text = "\(data.JobType)"
            cell.POL_Time.text = "INCO : \(data.INCO)"
        }
        else{
            cell.statusImage.image = UIImage(named:"ocean-transportation")
            cell.POL.text  = "POD :\(data.POL)"
            cell.POD.text = "FPOD :\(data.FPOD)"
            cell.Job_Id.text = "Shipping Line : \(data.Line_Name)"
            cell.POL_Time.text = "INCO : \(data.INCO)"
            
        }
        cell.notificationBackgroundView.layer.cornerRadius = 20
        cell.notificationBackgroundView.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data  = trackedData[indexPath.row]
        JOBID = data.JobID
        POL1 = data.POL
        POD2 = data.FPOD
        SL_AL = data.Line_Name
        INCO = data.INCO
        FRT_CLR = data.FRT_CLR
        SST_name = data.SST_name
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "JobStages", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "JobStages" {
            let nextScene =  segue.destination as! TrackingDetailsViewController
            nextScene.POD = POD2
            nextScene.POL = POL1
            nextScene.JOBID = JOBID
            nextScene.SL_AL = SL_AL
            nextScene.INCO = INCO
            nextScene.FRT_CLR = FRT_CLR
            nextScene.SST_name = SST_name
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
}
extension TrackingViewController{
    // MARK: - Searchbar Delegate methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.resignFirstResponder() // hides the keyboard.
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered_Data = trackedData.filter({ (model:Db_data) -> Bool in
            return model.FRT_CLR.lowercased().range(of:searchText.lowercased()) != nil || model.Line_Name.lowercased().range(of:searchText.lowercased()) != nil || model.POD.lowercased().range(of:searchText.lowercased()) != nil ||
                model.POL.lowercased().range(of:searchText.lowercased()) != nil || model.FPOD.lowercased().range(of:searchText.lowercased()) != nil
        })
        if searchText != ""{
            searchActive = true
            self.tableView.reloadData()
            
        }else{
            searchActive = false
            self.tableView.reloadData()
        }
    }
}

