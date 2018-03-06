//
//  ViewController.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 06/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import RealmSwift
//import NVActivityIndicatorView
var kNOTIFICATION_LIST = "NOTIFICATION_LIST"

struct NotificationModel:Decodable{
    var db_status:String
    var db_data:[db_data]
}

struct db_data:Decodable{
    var nt_title:String
    var nt_body:String
    var nt_date:String
    var nt_job_id:String
    var nt_flag:String    
}

class NotificationsViewController: UIViewController,ShowAlertView{
    let kUserDefault = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    let app = AppColor()
    let loader = AppLoader()
    var notification = NSMutableDictionary()
    //    var dataSource:Results<Notifications>!
    var dataSource = [db_data]()
    var INCO:String?
    var Line_Name:String?
    var FRT_CLR:String?
    
    var SST_name:String?
    
    var POL1:String!
    var POD2:String!
    
    var JOBID:String!
    var lists : Results<Notifications>!
    
    var appDelrealm:Realm!
//    var notificationList : Results<Notifications>{
//        get {
//            return appDelrealm.objects(Notifications.self)
//        }
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.backgroundColor = app.hexStringToUIColor(hex: "4C7FFF")
        self.view.backgroundColor = loader.bg
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
//        appDelrealm = try! Realm()
        getNotificationList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loader.show();
        //        notifications()
    }
    func notifications(){
//        lists = appDelrealm.objects(Notifications.self)
        loader.dismiss()
    }
    func getNotificationList(){
        let loader = AppLoader()
        loader.show();
        //            let navigationController = NavigationControllers()
        //            let userinfo = profileUserInfo()
        //        let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/track_data_get"
        let api = APIConstant()
        let url = api.developemntURL + "fetch_notif_client"
        //            let userDefaultDetails = UserDefaultDetails()
        let kUserDefault = UserDefaults.standard
        let param = "auth_token=\(kUserDefault.value(forKey: "auth_token")!)"
        print(url,param)
        DataManager.getJSONFromURL(url, param:param, completion: { (data, error) in
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(NotificationModel.self, from: data!)
                
                if json.db_status == "true"{
                    self.dataSource  = json.db_data
                    let notifications = Notifications()
                    //                    for i in self.dataSource{
                    //                        notifications.title = i.nt_title
                    //                        notifications.body = i.nt_body
                    //                        notifications.nt_flag = i.nt_flag
                    //                        notifications.notificationTime = i.nt_date
                    //                        notifications.nt_job_id = i.nt_job_id
                    //                        do {
                    //                            try self.appDelrealm.write{
                    ////                                self.appDelrealm.refresh()
                    ////                                self.appDelrealm.add(notifications)
                    //                            }
                    //                        }catch let error {
                    //                            print(error)
                    //                        }
                    //                    }
                    
                    self.notifications()
                    DispatchQueue.main.async {
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

extension NotificationsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSection: NSInteger = 0
        if dataSource.count > 0   {
            self.tableView.backgroundView = nil
            numOfSection = 1
        }
        else
        {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x:0, y:0, width:self.tableView.bounds.size.width, height:self.tableView.bounds.size.height))
            noDataLabel.text = "No Notifications Available"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = noDataLabel
        }
        return numOfSection
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotificationCell
        let data = dataSource[indexPath.row]
        if indexPath.row / 2 == 0{
            cell.notificationView.backgroundColor = UIColor.lightGray
            cell.notificationBackgroundView.backgroundColor = UIColor.white
            
        }else{
            cell.notificationView.backgroundColor = app.hexStringToUIColor(hex: "0090CF")            
        }
        cell.notificationBackgroundView.layer.cornerRadius = 20
        cell.notificationBackgroundView.layer.masksToBounds = true
        //        cell.notificationBackgroundView.backgroundColor = app.hexStringToUIColor(hex: "0D91CE")
        cell.notificationView.layer.cornerRadius = 7
        cell.notificationView.layer.masksToBounds = true
        cell.notificationTitle.text = data.nt_title
        cell.notificationDescription.text = data.nt_body
        cell.NotificationTime.text = data.nt_date
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data  = dataSource[indexPath.row]
        JOBID = data.nt_job_id
        print("didSelectRowAt")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "Stages", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Stages" {
            let nextScene =  segue.destination as! TrackingDetailsViewController
            nextScene.JOBID = JOBID
            
        }
    }
}

