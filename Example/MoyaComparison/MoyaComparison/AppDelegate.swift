//
// Copyright 2017 niji
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: - Public Properties
  var window: UIWindow?
  
  // MARK: - Private Properties
  private var appCoordinator: AppCoordinator?
  private var mainViewController: UIViewController {
    let mainViewController = UITabBarController()
    
    MCLogger.setup()
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    self.window?.rootViewController = mainViewController
    self.window?.makeKeyAndVisible()
    
    return mainViewController
  }

  // MARK: - Life Cycle
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.appCoordinator = AppCoordinator(mainViewController: self.mainViewController)
    self.appCoordinator?.start()
    return true
  }
}
