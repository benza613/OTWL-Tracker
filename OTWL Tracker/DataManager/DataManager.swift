//
//  ApiRequest.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 07/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import UIKit
public final class DataManager{
    public static func getJSONFromURL(_ api:String,param:String,completion:@escaping (_ data:Data?, _ error:Error?) -> Void){
        guard let url = URL(string:api) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        print(param)
        do {
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
    
}
extension String {
    var trimmed:String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

