//
//  GameViewController.swift
//  Olympic Snowballs
//
//  Created by Artem Galiev on 06.10.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let buttonMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: NameImage.menuButton.rawValue), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let skScene: GameScene = SKScene(fileNamed: "GameScene") as! GameScene

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonMenu.addTarget(self, action: #selector(onMenuButtonClick), for: .touchUpInside)
        
        let skView = SKView(frame: view.frame)
        view.addSubview(skView)
        
        skScene.size = CGSize(width: view.frame.width, height: view.frame.height)
        skScene.scaleMode = .aspectFill
        skView.presentScene(skScene)
            
        view.addSubview(buttonMenu)
        buttonMenu.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonMenu.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonMenu.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        buttonMenu.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        skScene.startGame()
    }
    
    @objc func onMenuButtonClick() {
        MainRouter.shared.closeGameViewScreen()
    }
}
