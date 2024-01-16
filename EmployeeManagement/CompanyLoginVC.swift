//
//  CompanyLoginVC.swift
//  EmployeeManagement
//
//  Created by Perennials on 12/01/24.
//

import UIKit

class CompanyLoginVC: UIViewController {

    @IBOutlet weak var companyId: UITextField!
    @IBOutlet weak var companyName: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    lazy var companyData = companiesData()
    lazy var employeesData = [EmployeeDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loginButton.layer.cornerRadius = 10
        self.readJSONFile()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - json reading
    func readJSONFile () {
        let fileName = "Company"
        let fileType = "json"
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(filePath: path),options: .mappedIfSafe)
                //        let data = try Data(NSData(contentsOfFile: URL(filePath: path), options: .mappedIfSafe))
//                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                print(jsonObject)
                
                let arrCompany = try? JSONDecoder().decode(companiesData.self, from: data)
//                print("company data is \(arrCompany)...")
                if let arr = arrCompany {
                    companyData = arr//saving for later use
                }
                
            }catch {
                print("json file not found")
            }
        }
        
    }
    
    func verifyLoginDetailsWithJsonData () -> Bool{
        for particularCompanyData in companyData {
//                        print(companyData.employeeDetails)
            //check for
            if particularCompanyData.companyID == Int(self.companyId.text!) && particularCompanyData.companyName == self.companyName.text! {
                employeesData = particularCompanyData.employeeDetails //saving particular employee details for employee list screen
                return true
            }
        }
        return false
    }
    
    @IBAction func login(_ sender: Any) {
        if let nameVal = companyId.text, let passwordVal = companyName.text {
            
            if validateLoginCredentials(companyId: nameVal, companyName: passwordVal) == true {
                //now check user entered values with local json data
                if self.verifyLoginDetailsWithJsonData() == true {
                    //show success message
                    showLoginSuccessAlertAndRedirect(title: "Login", message: "Login Success")
//                    showAlert(title: "Login", message: "Login Success")
                } else {
                    //show failure message
                    showAlert(title: "Login", message: "Login failed. Please check credentials.")
                }
            }
        }
        
    }
    
    func validateLoginCredentials(companyId: String, companyName: String) -> Bool {
            if companyId == "" || companyName == "" {
                //show an alert
                self.showAlert(title: "Alert", message: "All fields are mandatory")
                return false
            }
            if companyName.count < 3 {
                self.showAlert(title: "Alert", message: "Name should be more than 3 characters")
                return false
            }
            return true
        }
    
    //MARK: - alerts
    func showAlert(title:String,message:String) {
            let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok" , style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    func showLoginSuccessAlertAndRedirect(title:String,message:String) {
            let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: title, style: .default) {
            UIAlertAction in
            // redirect user to employee list screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "employeeVc") as?EmployeeViewController {
                vc.employeesData = self.employeesData
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
}
