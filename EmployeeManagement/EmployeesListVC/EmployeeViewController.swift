//
//  EmployeeViewController.swift
//  EmployeeManagement
//
//  Created by Perennials on 15/01/24.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var tableViewObj: UITableView!
    
//    var loggedInId = Int() //for logged in company id
//    var employeesData = [EmployeeDetail] ()
    var viewModel: EmployeeViewModel?

//    var companiesCompleteData = companiesData()

        //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let dataVal = viewModel?.getEmployeesDataBasedonCompany(companyId: Generic.shared.loggedInCompanyID ?? 0){
//            employeesData = dataVal
            //register cell with table
            let nib = UINib(nibName: "EmployeesCell", bundle: nil)
            tableViewObj.register(nib, forCellReuseIdentifier: "EmployeesCell")
            tableViewObj.dataSource = self
            tableViewObj.delegate = self
            tableViewObj.reloadData()
        }
        self.rightNavigationBar()
    }
    
    private func rightNavigationBar() {
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(logoutUser))
    }

    @objc func logoutUser() {
      self.viewModel?.deleteDataAndLogout()
    }
    
    @objc func resignationStatusChangeAction (sender:UISwitch) {
        if  let cell = sender.superview?.superview as? EmployeesCell {
            if let indexPath = self.tableViewObj.indexPath(for: cell) {
                if sender.isOn {
                    viewModel?.employeesData[indexPath.row].is_resigned = true
                } else {
                    viewModel?.employeesData[indexPath.row].is_resigned = false
                }
                //update json data now
                copyJSONFileToDocumentsDirectoryAndUpdateData()
                //show alert after updating data locally
            }
        }
    }
    
    func copyJSONFileToDocumentsDirectoryAndUpdateData() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let destinationURL = documentsURL?.appendingPathComponent("Company.json") {
            
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                viewModel?.updateJsonFile(companyId: Generic.shared.loggedInCompanyID ?? 0)
                
            } else {
                
                // Copy the file if it doesn't exist in the documents directory
                guard let sourcePath = Bundle.main.path(forResource: "Company", ofType: "json") else {
                        print("JSON file not found in the app bundle.")
                        return
                    }
                let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Company.json")
                do {
                    try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationURL.path())
                    viewModel?.updateJsonFile(companyId: Generic.shared.loggedInCompanyID ?? 0)

                    print("JSON file copied to documents directory.")

                } catch {
                    print("Error copying file to documents directory: \(error)")
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EmployeeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRow ?? 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "EmployeesCell", for: indexPath) as! EmployeesCell
        cell.employeeNameValue.text = viewModel?.employeesData[indexPath.row].name
        cell.resignationSwitch.addTarget(self, action: #selector(resignationStatusChangeAction), for: .valueChanged)
        if viewModel?.employeesData[indexPath.row].is_resigned == true {
            cell.resignationSwitch.isOn = true
        } else {
            cell.resignationSwitch.isOn = false
        }
        return cell
    }
    }

