//
//  CourseModels.swift
//  APIExample
//
//  Created by MacOs 10.15 Catalina on 04/01/2021.
//

import Foundation


struct CourseModel : Codable {
    let status_code : Int?
    let status : Bool?
    let message : String?
    let result : Result?
}

struct Result : Codable {
    let results : [Results]?
    let pagination : Pagination?
}

struct Pagination : Codable {
    let next : String?
    let num_pages : Int?
    let count : Int?
    let previous : String?
}

struct Results : Codable {
    let ratings : Double?
    let enrollments_count : Int?
    let modes : [Modes]?
    let name : String?
    let comments_count : Int?
    let difficulty_level : String?
    let discounted_price : Double?
    let verification_deadline : String?
    let discount_percentage : Double?
    let sale_type : String?
    let subcategory_id : String?
    let media : Media?
    let created : String?
    let discount_applicable : Bool?
    let is_premium : Bool?
    let id : String?
    let platform_visibility : String?
}

struct Modes : Codable {
    let sku : String?
    let expires : String?
    let name : String?
    let price : Int?
    let currency : String?
    let bulk_sku : String?
}

struct Media : Codable {
    let image : Image?
}

struct Image : Codable {
    let raw : String?
    let large : String?
    let small : String?
}
