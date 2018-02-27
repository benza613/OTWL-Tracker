//
//  ViewController.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 06/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView
class NotificationsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    let app = AppColor()
    let loader = AppLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 80
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loader.show();
        loader.dismiss()
    }
    
}

extension NotificationsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotificationCell
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
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

