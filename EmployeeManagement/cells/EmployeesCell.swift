//
//  EmployeesCell.swift
//  EmployeeManagement
//
//  Created by Perennials on 15/01/24.
//

import UIKit

class EmployeesCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var employeeNameValue: UILabel!
    
    @IBOutlet weak var resignedLabel: UILabel!
    
    @IBOutlet weak var resignationSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
