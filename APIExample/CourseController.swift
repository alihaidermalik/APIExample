//
//  CourseController.swift
//  APIExample
//
//  Created by MacOs 10.15 Catalina on 04/01/2021.
//

import Foundation

class CourseController{
    func getCourses(onCompletion: @escaping ((CourseModel) -> ())){
        RequestAPI().sendRequest(url: "http://134.209.96.11/api/commerce/v2/courses/", authorization: true){
            (response:CourseModel)  in
            onCompletion(response)
        }
    }
}
