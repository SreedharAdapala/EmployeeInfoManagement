//
//  DashboardViewModel.swift
//  MVVM-C
//
//  Created by Perennials on 18/01/24.
//

import Foundation

public protocol EmployeeViewModeCoordinatorlDelegate: AnyObject {
  func logout()
}

public class EmployeeViewModel: NSObject {
   var employeesData = [EmployeeDetail]()
    
    var heightForRow: CGFloat {
        return CGFloat(80)
    }
    var numberOfItems: Int {
            return employeesData.count
        }
    
    func item(at index: Int) -> EmployeeDetail {
            return employeesData[index]
        }
    
  public weak var coordinatorDelegate: EmployeeViewModeCoordinatorlDelegate?
    public override init() {
  }
    
    func getEmployeesDataBasedonCompany (companyId:Int) ->[EmployeeDetail] {
        for particularCompanyData in Generic.shared.companiesData! {
            //check for
            if particularCompanyData.companyID == companyId {
              employeesData = particularCompanyData.employeeDetails //saving particular employee details for employee list screen
                    return employeesData
            }
        }
        return employeesData
    }
    
    public func deleteDataAndLogout() -> Void {
      self.coordinatorDelegate?.logout()
    }
    
    func updateJsonFile (companyId:Int) {
        if var dummyArray = Generic.shared.companiesData {
            for i in 0..<(Generic.shared.companiesData?.count ?? 0) {
                if dummyArray[i].companyID == companyId { //update this with
                    dummyArray[i].employeeDetails = self.employeesData
                    let encoder = JSONEncoder()
                    do {
                        let jsonData = try encoder.encode(dummyArray)
                        
                        // Step 4: Write the updated JSON data back to the file
                        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Company.json")
                        try jsonData.write(to: fileURL!, options: .atomic)
                        print("Data updated and written to file successfully.")
                    } catch {
                        print("Error updating and writing JSON data: \(error)")
                    }
                }
            }
        }
    }
}
