//
//  ViewController.swift
//  APIExample
//
//  Created by MacOs 10.15 Catalina on 04/01/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        let anonymousfunction = {(fetchedResultList:CourseModel) in
            let data  = fetchedResultList.result?.results
            print("-=-=-=-=-=-=-=-= COURSES -=-=-=-=-=-=-=-=")
            for i in 0..<data!.count{
                print(data![i].name!)
            }
        }
        
        CourseController().getCourses(onCompletion: anonymousfunction)
        
    }

}

