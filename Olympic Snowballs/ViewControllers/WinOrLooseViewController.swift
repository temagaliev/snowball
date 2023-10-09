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
    
    var isWin: Bool
    
    init(isWin: Bool) {
        self.isWin = isWin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch isWin {
        case true:
            bgView.image = UIImage(named: NameImage.winBg.rawValue)
            resultView.image = UIImage(named: NameImage.winView.rawValue)
        case false:
            bgView.image = UIImage(named: NameImage.loseBg.rawValue)
            resultView.image = UIImage(named: NameImage.looseView.rawValue)
        }

    }
    
    @IBAction func onMenuButtonClick(_ sender: UIButton) {
        MainRouter.shared.closeWinOrLooseViewScreen()
        MainRouter.shared.closeGameViewScreen()
    }
    
    @IBAction func onReplayButtonClick(_ sender: UIButton) {
        MainRouter.shared.closeWinOrLooseViewScreen()

    }
    
}
