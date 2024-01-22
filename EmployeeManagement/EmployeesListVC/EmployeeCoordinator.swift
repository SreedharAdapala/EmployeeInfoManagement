//
//  DashboardCoordinator.swift
//  MVVM-C
//
//  Created by Perennials on 18/01/24.
//

import UIKit

protocol EmployeeCoordinatorDelegate: AnyObject {
  func didFinishEmployeeCordinator(coordinator: Coordinator)
}

class EmployeeCoordinator: BaseCoordinator {
  
  private let navigationcontroller: UINavigationController
  public weak var delegate: EmployeeCoordinatorDelegate?
//  private let user: User
  
  init(navigationcontroller:UINavigationController) {
    self.navigationcontroller = navigationcontroller
//    self.user = user
  }
  
  override func start() {
    if let controller = self.employeeViewController {
      self.navigationcontroller.setViewControllers([controller], animated: false)
    }
  }
  
  // init dashboard-controller with viewmodel dependency injection
  lazy var employeeViewController: EmployeeViewController? = {
    let controller = UIStoryboard(name: "Employee", bundle: nil).instantiateViewController(withIdentifier: "EmployeeViewController") as? EmployeeViewController
    let viewModel = EmployeeViewModel()
    controller?.viewModel = viewModel
    controller?.viewModel?.coordinatorDelegate = self
    return controller
  }()
}

extension EmployeeCoordinator: EmployeeViewModeCoordinatorlDelegate {
  func logout() {
    self.delegate?.didFinishEmployeeCordinator(coordinator: self)
  }
}
