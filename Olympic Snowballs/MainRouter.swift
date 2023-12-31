//
//  MainRouter.swift


import UIKit
import MessageUI

final class MainRouter {
    
    static let shared: MainRouter = MainRouter()
    
    private init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
    }
    
    private (set) var window: UIWindow
    private var rootViewController: UINavigationController?
    
    func showTmpMainScreen() {
        print("   ---   show main screen")
        let vc = MenuViewController(nibName: "MenuViewController", bundle: nil)
        
        self.rootViewController = UINavigationController(rootViewController: vc)
        self.window.rootViewController = self.rootViewController
        rootViewController?.setNavigationBarHidden(true, animated: true)

    }
    
    func showGameViewScreen() {
        rootViewController?.pushViewController(GameViewController(), animated: true)
    }
    
    func closeGameViewScreen() {
        rootViewController?.popViewController(animated: true)
    }
    
    func showTermsViewScreen() {
        rootViewController?.pushViewController(PrivacyPolicyViewController(), animated: true)
    }
    
    func closeTermsViewScreen() {
        rootViewController?.popViewController(animated: true)
    }
    
    func showWinOrLooseViewScreen(isWin: Bool, level: Int) {
        rootViewController?.pushViewController(WinOrLooseViewController(isWin: isWin, level: level), animated: true)
    }
    
    func closeWinOrLooseViewScreen() {
        rootViewController?.popViewController(animated: true)
    }

    
    private func pushToRoot(controller: UIViewController) {
        if let vc = rootViewController {
            if let topmostVC = vc.viewControllers.last, type(of: topmostVC) == type(of: controller) {
                vc.popViewController(animated: false)
                DispatchQueue.main.async {
                    vc.pushViewController(controller, animated: true)
                }
            } else {
                vc.pushViewController(controller, animated: true)
            }
        }
    }
}
