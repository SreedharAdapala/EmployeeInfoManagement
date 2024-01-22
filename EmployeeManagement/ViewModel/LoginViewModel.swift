//
//  LoginViewModel.swift
//  EmployeeManagement
//
//  Created by Perennials on 18/01/24.
//

import Foundation

public protocol LoginViewModelCoordinatorDelegate: AnyObject {
  func loginDidSuccess(with company: String)
  func loginFailed(message: String)
}

public class LoginViewModel: NSObject {
  
  private var login_status = ""
  
  public weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    
    public func onTapLogin(companyId:String,name:String) -> Void {
    
    // awesome REST API here
//    let dataFromServer = User(name: "admin")
        login_status = validateLoginCredentials(companyId: companyId, companyName: name)
    if login_status  == "success" {
        self.coordinatorDelegate?.loginDidSuccess(with: companyId)
    } else {
      self.coordinatorDelegate?.loginFailed(message: login_status)
    }
  }
    
    func validateLoginCredentials(companyId: String, companyName: String) -> String {
            if companyId == "" || companyName == "" {
                //show an alert
                return "All fields are mandatory"
            }
            else if companyName.count < 3 {
                return "Name should be more than 3 characters"
            } else {
                if verifyLoginDetailsWithJsonData(companyId: companyId, name: companyName) == true {
                    return "success"
                } else {
                    return "failed"
                }
            }
        }
    
    func verifyLoginDetailsWithJsonData (companyId:String,name:String) -> Bool{
        for particularCompanyData in Generic.shared.companiesData! {
            //check for
            if particularCompanyData.companyID == Int(companyId) && particularCompanyData.companyName == name {
                return true
            }
        }
        return false
    }
}
