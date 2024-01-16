//
//  CompanyViewModel.swift
//  EmployeeManagement
//
//  Created by Perennials on 15/01/24.
//

import Foundation

class CompanyViewModel {
    private var employeesData:[EmployeeDetail] = []
    
    func getNumberofRows() -> Int {
        return employeesData.count
    }
}
