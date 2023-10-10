//
//  WinOrLooseViewController.swift
//  Olympic Snowballs
//
//  Created by Artem Galiev on 06.10.2023.
//

import UIKit

class WinOrLooseViewController: UIViewController {

    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var resultView: UIImageView!
    @IBOutlet weak var constarintResultView: NSLayoutConstraint!
    
    @IBOutlet weak var labelPotinTwo: UILabel!
    @IBOutlet weak var labelPointOne: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var firstPostionLabel: UILabel!
    @IBOutlet weak var thirdPositionLabel: UILabel!
    
    var isWin: Bool
    var level: Int
    
    init(isWin: Bool, level: Int) {
        self.isWin = isWin
        self.level = level
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        switch isWin {
        case true:
            bgView.image = UIImage(named: NameImage.winBg.rawValue)
            resultView.image = UIImage(named: NameImage.winView.rawValue)
            constarintResultView.constant = 50
            playerPositionLabel.text = ""
            firstPostionLabel.text = ""
            thirdPositionLabel.text = ""
            labelPointOne.isHidden = true
            labelPotinTwo.isHidden = true

        case false:
            labelPointOne.isHidden = false
            labelPotinTwo.isHidden = false
            constarintResultView.constant = 16

            bgView.image = UIImage(named: NameImage.loseBg.rawValue)
            resultView.image = UIImage(named: NameImage.looseView.rawValue)
            
            firstPostionLabel.text = "1. Player8219 - HighScore: 760 level"
            switch level {
            case 1...20:
                let value = Int.random(in: 200...250)
                positionPlayer(position: value)
            case 21...40:
                let value = Int.random(in: 100...200)
                positionPlayer(position: value)
            case 41...60:
                let value = Int.random(in: 50...100)
                positionPlayer(position: value)
            case 61...80:
                let value = Int.random(in: 30...50)
                positionPlayer(position: value)
            case 81...150:
                let value = Int.random(in: 20...30)
                positionPlayer(position: value)
            case 151...300:
                let value = Int.random(in: 20...30)
                positionPlayer(position: value)
            case 301...450:
                let value = Int.random(in: 10...20)
                positionPlayer(position: value)
            case 451...550:
                let value = Int.random(in: 5...10)
                positionPlayer(position: value)
            case 551...760:
                let value = Int.random(in: 2...5)
                positionPlayer(position: value)
            default:
                let value = Int.random(in: 200...250)
                positionPlayer(position: value)
            }
        }
    }
    
    private func positionPlayer(position: Int) {
        playerPositionLabel.text = "\(position). You - HighScore: \(level) level"
        thirdPositionLabel.text = "\(position + 1). Player\(Int.random(in: 1000...9999)) - HighScore: \(level - 1) level"
    }
    
    @IBAction func onMenuButtonClick(_ sender: UIButton) {
        MainRouter.shared.closeWinOrLooseViewScreen()
        MainRouter.shared.closeGameViewScreen()
    }
    
    @IBAction func onReplayButtonClick(_ sender: UIButton) {
        MainRouter.shared.closeWinOrLooseViewScreen()

    }
    
}
