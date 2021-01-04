//
//  ViewController.swift
//  APIExample
//
//  Created by MacOs 10.15 Catalina on 04/01/2021.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = "Fetching courses please wait..."
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getData()
    }
    
    func getData(){
        let anonymousfunction = {(fetchedResultList:CourseModel) in
            let data  = fetchedResultList.result?.results
            
            DispatchQueue.main.async {
                print("-=-=-=-=-=-=-=-= COURSES -=-=-=-=-=-=-=-=")
                for i in 0..<data!.count{
                    print(data![i].name!)
                    self.label.text = "Courses Fetched check terminal"
                }
            }

        }
        
        CourseController().getCourses(onCompletion: anonymousfunction)
        
    }

}

