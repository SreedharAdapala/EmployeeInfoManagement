//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Bhooshan Patil on 31/07/21.
//

import Foundation
import UIKit

/**
 Your app should consist of multiple coordinators, one for each scene.
 But it should always have one “main” AppCoordinator, which will be owned by the App Delegate.
 The following code is an example of a basic AppCoordinator.
 All other coordinators in the application will be children of this coordinator.
 */

class AppCoordinator: BaseCoordinator {
  
  let LOGIN_STATUS = true
  
  // MARK: - Properties
  let window: UIWindow?
  
  lazy var rootViewController: UINavigationController = {
    return UINavigationController()
  }()
    
  //  the AppCoordinator it must own the window.
  init(window: UIWindow?) {
    self.window = window
  }
  
  override func start() {
    guard let window = window else { return }
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    
    if LOGIN_STATUS {
      loginFlow()
    } else {
      // user from local storage, as login is complete
//      let user = User(name: "admin")
        employeeFlow()
    }
  }
  
  private func loginFlow() {
    let loginCoordinator = LoginCoordinator(navigationcontroller: self.rootViewController)
    loginCoordinator.delegate = self
    store(coordinator: loginCoordinator)
    loginCoordinator.start()
  }
  
  private func employeeFlow() { //redirect to
      
    let employeeCoordinator = EmployeeCoordinator(navigationcontroller: self.rootViewController)
      employeeCoordinator.delegate = self
    store(coordinator: employeeCoordinator)
      employeeCoordinator.start()
  }
  
}

extension AppCoordinator: LoginCoordinatorDelegate {
  
  func didFinishLoginCordinator(coordinator: Coordinator) {
    self.free(coordinator: coordinator)
    self.employeeFlow()
  }
}

extension AppCoordinator: EmployeeCoordinatorDelegate {
  func didFinishEmployeeCordinator(coordinator: Coordinator) {
    self.free(coordinator: coordinator)
    self.loginFlow()
  }
}
