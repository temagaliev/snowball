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
    
    var labelScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var labelHighScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var saveHighScore: Int = 0
    
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
        view.addSubview(labelScore)
        view.addSubview(labelHighScore)
        
        buttonMenu.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonMenu.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonMenu.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        buttonMenu.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        
        labelHighScore.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        labelHighScore.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 60).isActive = true
        labelHighScore.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -60).isActive = true
        
        labelScore.topAnchor.constraint(equalTo: labelHighScore.bottomAnchor, constant: 8).isActive = true
        labelScore.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 60).isActive = true
        labelScore.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -60).isActive = true
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        skScene.startGame()
        highScoreCounter()
        labelScore.text = "Level - " + String(skScene.level)
        labelHighScore.text = "High score - \(saveHighScore)"
    }
    
    @objc func onMenuButtonClick() {
        MainRouter.shared.closeGameViewScreen()
    }
    
    private func highScoreCounter() {
        saveHighScore = UserDefaults.standard.integer(forKey: "saveScore")
        print("saveHighScore", saveHighScore)
        if saveHighScore < skScene.level - 1  {
            UserDefaults.standard.set(skScene.level - 1, forKey: "saveScore")
            saveHighScore = skScene.level - 1
        }
    }
}
