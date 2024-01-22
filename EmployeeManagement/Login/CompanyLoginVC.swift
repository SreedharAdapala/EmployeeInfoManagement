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
    
//    lazy var companyData = companiesData()
    lazy var employeesData = [EmployeeDetail]()
    var loginVM = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loginButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.readJSONDataFromDocumentsDirectory()
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
    func readJSONDataFromBundle () {
        let fileName = "Company"
        let fileType = "json"
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(filePath: path),options: .mappedIfSafe)
                let arrCompany = try? JSONDecoder().decode(companiesData.self, from: data)
//                print("company data is \(arrCompany)...")
                if let arr = arrCompany {
                    Generic.shared.companiesData = arr//saving for later use
                }
                
            }catch {
                print("json file not found")
            }
        }
        
    }
    
    func readJSONDataFromDocumentsDirectory() {
        // Get the URL of the documents directory
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found.")
            return
        }

        // Append the file name to the documents directory URL
        let fileURL = documentsDirectory.appendingPathComponent("Company.json")

        do {
            // Read the data from the file
            let data = try Data(contentsOf: fileURL)

            // Decode the JSON data using a JSONDecoder
            let decoder = JSONDecoder()
            Generic.shared.companiesData = try decoder.decode(companiesData.self, from: data)

        } catch {
            print("Error reading JSON data: \(error)")
            readJSONDataFromBundle() //if there is no file in documents directory then we read form bundle
            return
        }
    }
    
   
    
    @IBAction func login(_ sender: Any) {
        
        if let idVal = companyId.text, let nameVal = companyName.text {
            Generic.shared.loggedInCompanyID = Int(idVal)
            self.loginVM.onTapLogin(companyId: idVal, name: nameVal)
        }
        
    }
    
    public func displayAlertMessage(message: String) {
      let alertcontroller = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertcontroller.addAction(okAction)
      self.present(alertcontroller, animated: true, completion: nil)
    }
    
    deinit {
      print(#function , NSStringFromClass(CompanyLoginVC.self))
    }
}
