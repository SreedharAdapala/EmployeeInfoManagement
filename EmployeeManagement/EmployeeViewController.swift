//
//  EmployeeViewController.swift
//  EmployeeManagement
//
//  Created by Perennials on 15/01/24.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var tableViewObj: UITableView!
    
    var employeesData = [EmployeeDetail] ()
    
        //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //register cell with table
        let nib = UINib(nibName: "EmployeesCell", bundle: nil)
        tableViewObj.register(nib, forCellReuseIdentifier: "EmployeesCell")
        tableViewObj.dataSource = self
        tableViewObj.delegate = self
        tableViewObj.reloadData()
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
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "EmployeesCell", for: indexPath) as! EmployeesCell
        cell.employeeNameValue.text = employeesData[indexPath.row].name
        cell.resignationSwitch.addTarget(self, action: #selector(resignationStatusChangeAction), for: .valueChanged)
        if employeesData[indexPath.row].is_resigned == true {
            cell.resignationSwitch.isOn = true
        } else {
            cell.resignationSwitch.isOn = false
        }
        return cell
    }
    
   @objc func resignationStatusChangeAction () {
       let indexPath = IndexPath(row: 0, section: 0)
       let cell = tableViewObj.cellForRow(at: indexPath) as! EmployeesCell
//       cell.resignationSwitch
    }
    
}
