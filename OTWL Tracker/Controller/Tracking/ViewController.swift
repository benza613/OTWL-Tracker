//
//  ViewController.swift
//  DemoApp
//
//  Created by Sanjay Mali on 16/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
//
////struct Tracking:Decodable{
////    //    var db_status:String
////    var db_msg:String
////    var db_data:[Db_data]
////    
////}
////struct Db_data:Decodable{
////    var Status:String
////    var Job_Id:String
////    var Customer:String
////    var OA_Coloader_Courier:String
////    var SL_AL:String
////    var JobStages:[JobStages]
////    var Port_Info:String
////    
////}
////struct JobStages:Decodable{
////    var a1:String
////    var a2:String
////}
//class ViewController: UITableViewController,ShowAlertView{
//
////    let model = generateRandomData()
////    var storedOffsets = [Int: CGFloat]()
//    let app = AppColor()
//    let loader = AppLoader()
//    var trackedData = [Db_data]()
//    var jobStages = [JobStages]()
//    var storedOffsets = [Int: CGFloat]()
//    let model = generateRandomData()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.rowHeight = 200
//        self.tableView.sectionHeaderHeight = 70
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        trackingJobs()
//    }
//    
//   
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return trackedData.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let data = trackedData[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
////        cell.textLabel?.text = data.SL_AL
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt")
//    }
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        
////        guard let tableViewCell = cell as? TableViewCell else { return }
//        
////        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
////        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
//        
//    }
//    
////    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
////
////        guard let tableViewCell = cell as? TableViewCell else { return }
////        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
////
////
////    }
//    
//    
//    func trackingJobs(){
//        let loader = AppLoader()
//        loader.show();
//        let navigationController = NavigationControllers()
//        let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/track_data_get"
//        
//        let param = "resourceid=10"
//        DataManager.getJSONFromURL(url, param:param, completion: { (data, error) in
//            //                print(data)
//            let decoder = JSONDecoder()
//            do {
//                let json = try decoder.decode(Tracking.self, from: data!)
//                //                print(json)
//                //                let userDefaultDetails = UserDefaultDetails()
//                if json.db_msg == "true"{
//                    //                    userDefaultDetails.loggedIN(isLoggedIN: true)
//                    self.trackedData = json.db_data
//                    DispatchQueue.main.async {
//                        //                        navigationController.navigateTabbar()
//                        self.tableView.reloadData()
//                        loader.dismiss()
//                        
//                    }
//                }else{
//                    self.showAlert(message:json.db_msg)
//                    loader.dismiss()
//                }
//            }catch{
//                print(error.localizedDescription)
//                loader.dismiss()
//            }
//        })
//    }
//}
//
//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
////        cell.backgroundColor = UIColor.orange
////            model[collectionView.tag][indexPath.item]
//        cell.layer.cornerRadius = 20
//        cell.layer.masksToBounds = true
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//    }
//    
//
//}

