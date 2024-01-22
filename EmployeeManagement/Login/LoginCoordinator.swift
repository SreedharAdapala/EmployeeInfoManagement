//
//  LoginCoordinator.swift
//  MVVM-C
//
//  Created by Perennials on 18/01/24.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
  func didFinishLoginCordinator(coordinator: Coordinator)
}

/// LoginCoordinator handles the responsibility if naviagtion in login-module
final class LoginCoordinator: BaseCoordinator {
  
  private let navigationcontroller: UINavigationController
  public weak var delegate: LoginCoordinatorDelegate?
  
  init(navigationcontroller:UINavigationController) {
    self.navigationcontroller = navigationcontroller
  }
  
  override func start() {
    if let controller = self.loginController {
      self.navigationcontroller.setViewControllers([controller], animated: false)
    }
  }
  
  // init login-controller
  lazy var loginController: CompanyLoginVC? = {
    let viewModel = LoginViewModel()
    viewModel.coordinatorDelegate = self
    
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompanyLoginVC") as? CompanyLoginVC
    controller?.loginVM = viewModel
    return controller
  }()
  
}

extension LoginCoordinator: LoginViewModelCoordinatorDelegate {

    func loginDidSuccess(with company: String) {
            self.delegate?.didFinishLoginCordinator(coordinator: self)
    }
  
  func loginFailed(message: String) {
    self.loginController?.displayAlertMessage(message: message)
  }
}
