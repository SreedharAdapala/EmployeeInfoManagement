//
//  CompanyModel.swift
//  EmployeeManagement
//
//  Created by Perennials on 15/01/24.
//

import Foundation

// MARK: - Company
struct Companies: Codable {
    let companyID: Int
    let companyName: String
    var employeeDetails: [EmployeeDetail]
}

// MARK: - EmployeeDetail
struct EmployeeDetail: Codable {
    let id: Int
    let name, password: String
    var is_resigned:Bool
}

typealias companiesData = [Companies]

