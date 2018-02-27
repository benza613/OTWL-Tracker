//
//  ApiRequest.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 07/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//
import Foundation
import Alamofire
import UIKit
public final class DataManager {
    public static func getJSONFromURL(_ api:String,param:String,completion:@escaping (_ data:Data?, _ error:Error?) -> Void){
        guard let url = URL(string:api) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //        let dic2 = "hparam=\(param)"
        //        print(api)
        
        //        let p = "hparam=" + "\(param)" + "}"
        
        
        
//        let jsonBody = try JSONEncoder().encode(param)
        
  print(param)
        do {
//            let jsonBody = try JSONEncoder().encode(param)
//            request.httpBody = jsonBody
            let data = param.data(using: .utf8)!
             request.httpBody = data
        } catch {
            print("Something went wrong")
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                if let er  = error  {
                    print("error = \(er.localizedDescription)")
                }
                guard let mdata = data else {
                    return
                }
                completion(data,nil)
            }
            catch{
                print(error)
            }
            }.resume()
    }
    
    class func alamfireRequest(_ api:String,param:[String:[String:String]]){
        //        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        //        let parameters = []
        let dic2 = "hparam=\(param)"
        let urlendcoded = "\(api)" + "\(dic2)"
        let url = urlendcoded.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        print("newUrl:\(urlendcoded)")
        Alamofire.request(url, method: .post, parameters:nil, encoding:URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            print(urlendcoded)
            print(response.data)
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            print(encodedUrl!)
            let urlEncoded = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlHostAllowed)
            print(urlEncoded!)
            switch(response.result) {
            case.success(let data):
                print("success",data)
            case.failure(let error):
                print("Not Success",error)
            }
            //         "http://apiocean20180207065702.azurewebsites.net/api/ocean/json_data_get_d?hparam={\n  \"usr_signup\" : {\n    \"usrr_fnm\" : \"Sanjay\",\n    \"usrr_psw\" : \"sasasa\",\n    \"usrr_mb_pfx\" : \"+91\",\n    \"usrr_eml\" : \"s@gmail.com\",\n    \"usrr_mb_no\" : \"2121212\",\n    \"usrr_lnm\" : \"Malis\",\n    \"usrr_pfl\" : \"-\"\n  }\n}"
        }
        /*
         let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
         Alamofire.request(urlendcoded, method: .get, parameters: nil, headers: nil).responseJSON { (response:DataResponse<Any>) in
         switch(response.result) {
         case .success(_):
         if let data = response.result.value{
         print(response.result.value)
         }
         break
         
         case .failure(_):
         print(response.result.error)
         break
         
         }
         }
         */
    }
}
extension String {
    var trimmed:String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

