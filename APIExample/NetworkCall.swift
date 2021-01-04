//
//  NetworkCall.swift
//  APIExample
//
//  Created by MacOs 10.15 Catalina on 04/01/2021.
//

import Foundation

//
//  RequestAPI.swift
//  learninghub
//
//  Created by Knysys on 01/12/2020.
//  Copyright © 2020 gridsynergy. All rights reserved.
//

import Foundation
import UIKit

enum HTTPRequest{
    case get
    case post
    case put
    case delete
    case patch
}

class RequestAPI{
    
    func sendRequest<T: Decodable>(url: String, requestType:HTTPRequest = .get, authorization:Bool=false, body:[String:Any] = [String:Any](), data:String = "", completion: @escaping (T) -> ()){
        
        let requrl = URL(string: url)
        var request = URLRequest(url:requrl!)
                
        if(authorization){
            let token = "ProOXKVkTqF1BFdVnXheGHCjRbTL30"
            request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        }
        
        if(!body.isEmpty){
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            if requestType != .patch{
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
            }
            
        }
        
        if(data != ""){
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
            request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
            request.httpBody = Data(data.utf8)
            //print("data: \(data.utf8)")
        }
        
        switch requestType {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
        case .delete:
            request.httpMethod = "DELETE"
        case .put:
            request.httpMethod = "PUT"
            
        case .patch:
            request.addValue("application/merge-patch+json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/merge-patch+json", forHTTPHeaderField: "Accept")
            request.httpMethod = "PATCH"
        }
        
        let task = URLSession.shared.dataTask(with: request){ data,resp,error in
            //print("================================= response")
            //print(String(data: data ?? Data.init(), encoding: .utf8) ?? "")
            if(requestType != .post || requestType != .put){
                
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(model)
                    } catch let jsonErr {
                        print("failed to decode, \(jsonErr)")
                    }
                }else{
                    //completion(EmptyModel)
                    print("Data not found")
                }
                
            }
        }
        task.resume()
    }
    
    func sendNoResponseRequest(url: String, requestType:HTTPRequest = .get, authorization:Bool=false, body:[String:Any] = [String:Any](), data:String = "", completion: @escaping (Int) -> ()){
        
        var result = false
        let requrl = URL(string: url)
        var request = URLRequest(url:requrl!)
        
        if(!body.isEmpty){
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        if(data != ""){
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
            request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
            request.httpBody = Data(data.utf8)
            print("data: \(data.utf8)")
        }
        
        switch requestType {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
        case .delete:
            request.httpMethod = "DELETE"
        case .put:
            request.httpMethod = "PUT"
        case .patch:
            request.httpMethod = "PATCH"
        }
        
        let task = URLSession.shared.dataTask(with: request){ data,resp,error in
            print("================================= response")
            print(String(data: data ?? Data.init(), encoding: .utf8) ?? "")
            
            if let httpResponse = resp as? HTTPURLResponse {
                
                let statuscode = httpResponse.statusCode
                print("statusCode: \(statuscode)")
                
                completion(statuscode)
            }
        }
        task.resume()
    }
    
    func sendNoResponseRequest1(url: String, requestType:HTTPRequest = .get, authorization:Bool=false, body:[String:Any] = [String:Any](), data:String = "", completion: @escaping (String) -> ()){
        
        let requrl = URL(string: url)
        var request = URLRequest(url:requrl!)
        
        if(!body.isEmpty){
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        if(data != ""){
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
            request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
            request.httpBody = Data(data.utf8)
            print("data: \(data.utf8)")
        }
        
        switch requestType {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
        case .delete:
            request.httpMethod = "DELETE"
        case .put:
            request.httpMethod = "PUT"
        case .patch:
            request.httpMethod = "PATCH"
        }
        
        let task = URLSession.shared.dataTask(with: request){ data,resp,error in
            print("================================= response")
            print(String(data: data ?? Data.init(), encoding: .utf8) ?? "")
            let d = String(data: data ?? Data.init(), encoding: .utf8) ?? ""
            completion(d)
        }
        task.resume()
    }
    
    
    func uploadImage(url: String, authorization:Bool=false, body:[String:Any] = [String:Any](), data:String = "", imageView: UIImageView, imageName: String = "file", imageExt: String = "jpeg"){
        
        if let image = imageView.image{
            let imageData = image.jpegData(compressionQuality: 1.0)
            
            let requrl = URL(string: url)
            var request = URLRequest(url:requrl!)
            print("Url: =-=--=-=-=-=-=- \(requrl)")
            
            if(authorization){
                let token = "ProOXKVkTqF1BFdVnXheGHCjRbTL30"
                request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
            }

            let boundary = "Boundary-\(NSUUID().uuidString)"
            request.httpMethod = "POST"
            let contentType = "multipart/form-data; boundary=\(boundary)"
            
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
            
            var uploadData = Data()
            
            uploadData.append(Data("\r\n--\(boundary)\r\n".utf8))
            uploadData.append(Data("Content-Disposition: form-data; name=\"picture\"; filename=\"\(imageName).\(imageExt)\"\r\n".utf8))
            uploadData.append(Data("Content-Type: image/png\r\n\r\n".utf8))
            uploadData.append(imageData!)
            uploadData.append(Data("\r\n--\(boundary)--\r\n".utf8))
            
            request.httpBody = uploadData
            
            let task = URLSession.shared.dataTask(with: request){ data,resp,error in
                print("================================= response")
                print(String(data: data ?? Data.init(), encoding: .utf8) ?? "")
            }
            task.resume()
        }
    }
}

struct EmptyModel {
    var empty = true
}
