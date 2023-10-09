//
//  GameScene.swift
//  Olympic Snowballs
//
//  Created by Artem Galiev on 06.10.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var backgraundNode = SKSpriteNode(imageNamed: NameImage.bg.rawValue)
    var zeusMove = SKSpriteNode()
    var arrayNode: [SKSpriteNode] = []
    var arrayHadesActive: [SKSpriteNode] = []
    var arrayShot: [SKSpriteNode] = []
    var arrayHadesDead: [SKSpriteNode] = []
    
    let zeusNodeOne = SKSpriteNode(imageNamed: NameImage.zeusFirstPosition.rawValue)
    var isZeusNodeOneTouched: Bool = false
    var isZeusNodeOneDead: Bool = false
    
    let zeusNodeTwo = SKSpriteNode(imageNamed: NameImage.zeusFirstPosition.rawValue)
    var isZeusNodeTwoTouched: Bool = false
    var isZeusNodeTwoDead: Bool = false
    
    let zeusNodeThree = SKSpriteNode(imageNamed: NameImage.zeusFirstPosition.rawValue)
    var isZeusNodeThreeTouched: Bool = false
    var isZeusNodeThreeDead: Bool = false
    
    var isDeadZeus: Bool = false
    var isDeadHades: Bool = false
    var nameDeadZeus: String = ""
    var nameDeadHades: String = ""
    var isEnd: Bool = false
    
    let animationZeusShot: [SKTexture] = [SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue), SKTexture(imageNamed: NameImage.zeusSecondPosition.rawValue), SKTexture(imageNamed: NameImage.zeusThirdPosition.rawValue), SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue)]
    
    let animationHadesShot: [SKTexture] = [SKTexture(imageNamed: NameImage.hadesFirstPosition.rawValue), SKTexture(imageNamed: NameImage.hadesSecondPosition.rawValue), SKTexture(imageNamed: NameImage.hadesThirdPosition.rawValue), SKTexture(imageNamed: NameImage.hadesFirstPosition.rawValue)]
    
    override func didMove(to view: SKView) {
        backgraundNode.position = CGPoint(x: 0, y: 0)
        backgraundNode.size = CGSize(width: frame.width, height: frame.height)
        addChild(backgraundNode)
        addChild(zeusNodeOne)
        addChild(zeusNodeTwo)
        addChild(zeusNodeThree)

        createDefWall()

        view.scene?.delegate = self
        physicsWorld.contactDelegate = self
    }
    
    //MARK: - Touches методы
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if zeusNodeOne.contains(touch.location(in: self)) {
                isZeusNodeOneTouched = true
            } else if zeusNodeTwo.contains(touch.location(in: self)) {
                isZeusNodeTwoTouched = true
            } else if zeusNodeThree.contains(touch.location(in: self)) {
                isZeusNodeThreeTouched = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveZeus(isZeus: isZeusNodeOneTouched, zeus: zeusNodeOne, isDead: isZeusNodeOneDead, touches: touches)
        moveZeus(isZeus: isZeusNodeTwoTouched, zeus: zeusNodeTwo, isDead: isZeusNodeTwoDead, touches: touches)
        moveZeus(isZeus: isZeusNodeThreeTouched, zeus: zeusNodeThree, isDead: isZeusNodeThreeDead, touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isZeusNodeOneTouched || isZeusNodeTwoTouched || isZeusNodeThreeTouched {
            attackZeus(zeus: zeusMove)
        }
        zeusMove = SKSpriteNode()
        isZeusNodeOneTouched = false
        isZeusNodeTwoTouched = false
        isZeusNodeThreeTouched = false
    }
    
    public func startGame() {
        createZueses()
        createHades(numberOfHades: 3)
        moveHades()

    }
    
    //MARK: - Настройки зевса
 
    private func createZueses() {
        
        zeusNodeOne.texture = SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue)
        zeusNodeOne.size = CGSize(width: 45, height: 55)
        zeusNodeOne.position = CGPoint(x: frame.minX / 2, y: frame.minY / 2 + 50)
        zeusNodeOne.physicsBody = SKPhysicsBody(rectangleOf: zeusNodeOne.size)
        zeusNodeOne.physicsBody?.affectedByGravity = false
        zeusNodeOne.physicsBody?.isDynamic = false
        zeusNodeOne.physicsBody?.categoryBitMask = UInt32(BodyType.zeus)
        zeusNodeOne.physicsBody?.collisionBitMask = UInt32(BodyType.hadesGun)
        zeusNodeOne.physicsBody?.contactTestBitMask = UInt32(BodyType.hadesGun)
        
        zeusNodeOne.name = PlayerName.zeusNumberOne.rawValue
        isZeusNodeOneDead = false
        
        zeusNodeTwo.texture = SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue)
        zeusNodeTwo.size = CGSize(width: 45, height: 55)
        zeusNodeTwo.position = CGPoint(x: frame.minX / 2, y: frame.minY / 2)
        zeusNodeTwo.physicsBody = SKPhysicsBody(rectangleOf: zeusNodeTwo.size)
        zeusNodeTwo.physicsBody?.affectedByGravity = false
        zeusNodeTwo.physicsBody?.isDynamic = false
        zeusNodeTwo.physicsBody?.categoryBitMask = UInt32(BodyType.zeus)
        zeusNodeTwo.physicsBody?.collisionBitMask = UInt32(BodyType.hadesGun)
        zeusNodeTwo.physicsBody?.contactTestBitMask = UInt32(BodyType.hadesGun)
        
        zeusNodeTwo.name = PlayerName.zeusNumberTwo.rawValue
        isZeusNodeTwoDead = false
        
        zeusNodeThree.texture = SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue)
        zeusNodeThree.size = CGSize(width: 45, height: 55)
        zeusNodeThree.position = CGPoint(x: frame.minX / 2, y: frame.minY / 2 - 50)
        zeusNodeThree.physicsBody = SKPhysicsBody(rectangleOf: zeusNodeThree.size)
        zeusNodeThree.physicsBody?.affectedByGravity = false
        zeusNodeThree.physicsBody?.isDynamic = false
        zeusNodeThree.physicsBody?.categoryBitMask = UInt32(BodyType.zeus)
        zeusNodeThree.physicsBody?.collisionBitMask = UInt32(BodyType.hadesGun)
        zeusNodeThree.physicsBody?.contactTestBitMask = UInt32(BodyType.hadesGun)
        
        zeusNodeThree.name = PlayerName.zeusNumberThree.rawValue
        
        isZeusNodeThreeDead = false
        isEnd = false
        arrayNode = []
        arrayHadesActive = []

    }
    
    //MARK: - Создание врагов
    private func createHades(numberOfHades: Int) {
        for numberName in 1...numberOfHades {
            let hadesNode = SKSpriteNode(imageNamed: NameImage.hadesFirstPosition.rawValue)
            hadesNode.size = CGSize(width: 45, height: 55)
            let randomXPositionHades = CGFloat.random(in: (frame.midX + 20)...(frame.maxX - 20))
            let randomYPositionHades = CGFloat.random(in: (frame.minY / 2 - 70)...(frame.minY / 2 + 70))
            
            hadesNode.position = CGPoint(x: randomXPositionHades, y: randomYPositionHades)
            
            hadesNode.physicsBody = SKPhysicsBody(rectangleOf: hadesNode.size)
            hadesNode.physicsBody?.affectedByGravity = false
            hadesNode.physicsBody?.isDynamic = false
            hadesNode.physicsBody?.categoryBitMask = UInt32(BodyType.hades)
            hadesNode.physicsBody?.collisionBitMask = UInt32(BodyType.zeusGun)
            hadesNode.physicsBody?.contactTestBitMask = UInt32(BodyType.zeusGun)
            
            hadesNode.name = String(numberName)

            addChild(hadesNode)
            arrayNode.append(hadesNode)
        }
    }
    
    //MARK: - Движение врагов
    private func moveHades() {
        arrayHadesActive = arrayNode
        let actionMain = SKAction.customAction(withDuration: 0) { _,_ in
            if self.arrayHadesActive.count != 0 {
                let randonHades = Int.random(in: 0...self.arrayHadesActive.count - 1)
                let hadesNode = self.arrayHadesActive[randonHades]
                
                let actionShot = SKAction.customAction(withDuration: 0, actionBlock: {_,_ in
                    self.attackHades(hades: hadesNode)
                })
                
                let actionMove = SKAction.customAction(withDuration: 0) { node, _ in
                    let randomXPositionHades = CGFloat.random(in: (self.frame.maxX / 2 - 50)...(self.frame.maxX / 2 + 50))
                    let randomYPositionHades = CGFloat.random(in: (self.frame.minY / 2 - 70)...(self.frame.minY / 2 + 70))
                    
                    let move = SKAction.move(to: CGPoint(x: randomXPositionHades, y: randomYPositionHades), duration: 0.3)
                    node.run(move)
                    
                }
                let waitForViewAction = SKAction.wait(forDuration: 1)
                let sequance = SKAction.sequence([actionMove, waitForViewAction, actionShot,waitForViewAction])
                
                hadesNode.run(sequance)
                
            }
        }
        let waitForViewAction = SKAction.wait(forDuration: 1)
        let sequance = SKAction.sequence([waitForViewAction, actionMain])
        
        self.run(SKAction.repeatForever(sequance), withKey: "forever")
        
    }
    
    //MARK: - Создание защитных стен
    private func createDefWall() {
        
        let zeusDefWall = SKSpriteNode(imageNamed: NameImage.wallDefZeus.rawValue)
        zeusDefWall.size = CGSize(width: 30, height: 30)
        zeusDefWall.position = CGPoint(x: frame.minX / 2 + 100, y: frame.minY / 2 - 30)
        zeusDefWall.physicsBody = SKPhysicsBody(rectangleOf: zeusDefWall.size)
        zeusDefWall.physicsBody?.affectedByGravity = false
        zeusDefWall.physicsBody?.isDynamic = false
        zeusDefWall.physicsBody?.categoryBitMask = UInt32(BodyType.wallZeus)
        zeusDefWall.physicsBody?.collisionBitMask = UInt32(BodyType.hadesGun)
        zeusDefWall.physicsBody?.contactTestBitMask = UInt32(BodyType.hadesGun)
        zeusDefWall.physicsBody?.collisionBitMask = UInt32(BodyType.zeusGun)
        zeusDefWall.physicsBody?.contactTestBitMask = UInt32(BodyType.zeusGun)
        addChild(zeusDefWall)
        
        let hadesDefWall = SKSpriteNode(imageNamed: NameImage.wallDefHades.rawValue)
        hadesDefWall.size = CGSize(width: 30, height: 30)
        hadesDefWall.position = CGPoint(x: frame.maxX / 2 - 100, y: frame.minY / 2 + 30)
        hadesDefWall.physicsBody = SKPhysicsBody(rectangleOf: hadesDefWall.size)
        hadesDefWall.physicsBody?.affectedByGravity = false
        hadesDefWall.physicsBody?.isDynamic = false
        hadesDefWall.physicsBody?.categoryBitMask = UInt32(BodyType.wallHades)
        hadesDefWall.physicsBody?.collisionBitMask = UInt32(BodyType.zeusGun)
        hadesDefWall.physicsBody?.contactTestBitMask = UInt32(BodyType.zeusGun)
        hadesDefWall.physicsBody?.collisionBitMask = UInt32(BodyType.hadesGun)
        hadesDefWall.physicsBody?.contactTestBitMask = UInt32(BodyType.hadesGun)
        addChild(hadesDefWall)
    }
    
    //MARK: - Атака игрока
    private func attackZeus(zeus: SKSpriteNode) {
        if zeus.position.x != 0.0 && zeus.position.y != 0.0 {
            let shot = SKSpriteNode(imageNamed: NameImage.gunZues.rawValue)
            shot.size = CGSize(width: 50, height: 20)
            
            shot.position = zeus.position
            
            shot.physicsBody = SKPhysicsBody(circleOfRadius: 5)
            shot.physicsBody?.isDynamic = true
            shot.physicsBody?.affectedByGravity = false
            
            shot.physicsBody?.categoryBitMask = UInt32(BodyType.zeusGun)
            shot.physicsBody?.collisionBitMask = UInt32(BodyType.hades)
            shot.physicsBody?.contactTestBitMask = UInt32(BodyType.hades)
            shot.physicsBody?.collisionBitMask = UInt32(BodyType.hadesGun)
            shot.physicsBody?.contactTestBitMask = UInt32(BodyType.hadesGun)
            shot.physicsBody?.collisionBitMask = UInt32(BodyType.wallZeus)
            shot.physicsBody?.contactTestBitMask = UInt32(BodyType.wallZeus)
            shot.physicsBody?.collisionBitMask = UInt32(BodyType.wallHades)
            shot.physicsBody?.contactTestBitMask = UInt32(BodyType.wallHades)
            
            shot.physicsBody?.usesPreciseCollisionDetection = true
            
            self.addChild(shot)
            
            let animationDuration: TimeInterval = 3
            
            var actionArray = [SKAction]()
            
            let walkAnimation = SKAction.animate(with: animationZeusShot,
                                                 timePerFrame: 0.07)

            zeus.run(walkAnimation)
            actionArray.append(SKAction.move(to: CGPoint(x: self.frame.size.width, y: zeus.position.y), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            
            shot.run(SKAction.sequence(actionArray))
        }
    }
    
    //MARK: - Атака врага
    private func attackHades(hades: SKSpriteNode) {
        
        let shot = SKSpriteNode(imageNamed: NameImage.gunHades.rawValue)
        shot.size = CGSize(width: 10, height: 10)
        shot.position = hades.position
        shot.physicsBody = SKPhysicsBody(circleOfRadius: shot.size.width / 2)
        shot.physicsBody?.isDynamic = true
        shot.physicsBody?.affectedByGravity = false
        
        shot.physicsBody?.categoryBitMask = UInt32(BodyType.hadesGun)
        shot.physicsBody?.collisionBitMask = UInt32(BodyType.zeus)
        shot.physicsBody?.contactTestBitMask = UInt32(BodyType.zeus)
        shot.physicsBody?.collisionBitMask = UInt32(BodyType.zeusGun)
        shot.physicsBody?.contactTestBitMask = UInt32(BodyType.zeusGun)
        shot.physicsBody?.collisionBitMask = UInt32(BodyType.wallZeus)
        shot.physicsBody?.contactTestBitMask = UInt32(BodyType.wallZeus)
        shot.physicsBody?.collisionBitMask = UInt32(BodyType.wallHades)
        shot.physicsBody?.contactTestBitMask = UInt32(BodyType.wallHades)

        shot.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(shot)
        
        let animationDuration: TimeInterval = 3
        
        var actionArray = [SKAction]()
        arrayShot.append(shot)
        let walkAnimation = SKAction.animate(with: animationHadesShot,
                                             timePerFrame: 0.07)
        hades.run(walkAnimation)
        actionArray.append(SKAction.move(to: CGPoint(x: -self.frame.size.width, y: hades.position.y), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        shot.run(SKAction.sequence(actionArray))
    }
    
    //MARK: - Движение зевса
    private func moveZeus(isZeus: Bool, zeus: SKSpriteNode, isDead: Bool, touches: Set<UITouch>) {
        if isDead == false {
            if isZeus == true {
                if let touch = touches.first {
                    let touchLoc = touch.location(in: self)
                    let prevTouchLoc = touch.previousLocation(in: self)
                    let location = touch.location(in: self)
                    let move = SKAction.move(to: location, duration: 0.1)
                    zeus.run(move)
                    let newYPos = zeus.position.y + (touchLoc.y - prevTouchLoc.y)
                    let newXPos = zeus.position.x + (touchLoc.x - prevTouchLoc.x)
                    zeus.position = CGPoint(x: newXPos, y: newYPos)
                    self.zeusMove = zeus
                }
            }
        }
    }
}

//MARK: - SKSceneDelegate
extension GameScene: SKSceneDelegate {
    override func update(_ currentTime: TimeInterval) {
        if isZeusNodeOneDead {
            zeusNodeOne.texture = SKTexture(imageNamed: NameImage.zeusDead.rawValue)
        } else {
            zeusNodeOne.texture = SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue)
        }
        if isZeusNodeTwoDead {
            zeusNodeTwo.texture = SKTexture(imageNamed: NameImage.zeusDead.rawValue)
        } else {
            zeusNodeTwo.texture = SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue)
        }
        if isZeusNodeThreeDead {
            zeusNodeThree.texture = SKTexture(imageNamed: NameImage.zeusDead.rawValue)
        } else {
            zeusNodeThree.texture = SKTexture(imageNamed: NameImage.zeusFirstPosition.rawValue)
        }
//        
        for hades in arrayHadesDead {
            hades.texture = SKTexture(imageNamed: NameImage.hadesDead.rawValue)
        }

        if isEnd == false {
            if isDeadZeus {
                switch nameDeadZeus {
                case zeusNodeOne.name:
                    zeusNodeOne.texture = SKTexture(imageNamed: NameImage.zeusDead.rawValue)
                    zeusNodeOne.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 0, height: 0))
                    zeusNodeOne.size = CGSize(width: 60, height: 50)
                    isZeusNodeOneDead = true
                case zeusNodeTwo.name:
                    zeusNodeTwo.texture = SKTexture(imageNamed: NameImage.zeusDead.rawValue)
                    zeusNodeTwo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 0, height: 0))
                    zeusNodeTwo.size = CGSize(width: 60, height: 50)
                    isZeusNodeTwoDead = true
                case zeusNodeThree.name:
                    zeusNodeThree.texture = SKTexture(imageNamed: NameImage.zeusDead.rawValue)
                    zeusNodeThree.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 0, height: 0))
                    zeusNodeThree.size = CGSize(width: 60, height: 50)
                    isZeusNodeThreeDead = true
                default:
                    print("error in update")
                }
                isDeadZeus = false
                nameDeadZeus = ""
                
            }
            if isDeadHades {
                for i in 0...arrayHadesActive.count - 1 {
                    if arrayHadesActive[i].name == nameDeadHades {
                        arrayHadesActive[i].texture = SKTexture(imageNamed: NameImage.hadesDead.rawValue)
                        arrayHadesActive[i].size = CGSize(width: 50, height: 30)
                        arrayHadesActive[i].physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 0, height: 0))
                        arrayHadesDead.append(arrayHadesActive[i])
                        arrayHadesActive.remove(at: i)
                        break
                    }
                }
                isDeadHades = false
                nameDeadHades = ""
                
            }
            if isZeusNodeOneDead && isZeusNodeTwoDead && isZeusNodeThreeDead && arrayHadesActive.count != 0 {
                MainRouter.shared.showWinOrLooseViewScreen(isWin: false)
                isEnd = true
                for node in arrayNode {
                    node.removeFromParent()
                }
                for item in arrayShot {
                    item.removeFromParent()
                }
                SKAction.removeFromParent()
                self.removeAction(forKey: "forever")
            } else if arrayHadesActive.count == 0 {
                MainRouter.shared.showWinOrLooseViewScreen(isWin: true)
                isEnd = true
                for node in arrayNode {
                    node.removeFromParent()
                }
                for item in arrayShot {
                    item.removeFromParent()
                }
                self.removeAction(forKey: "forever")

                SKAction.removeFromParent()
            }
        }
    }
}

//MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    //Столкновения
    func didBegin(_ contact: SKPhysicsContact) {
            
        //Переменные контакта
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask
        
        let zeus = UInt32(BodyType.zeus)
        let zeusGun = UInt32(BodyType.zeusGun)
        let wallZeus = UInt32(BodyType.wallZeus)

        let hades = UInt32(BodyType.hades)
        let hadesGun = UInt32(BodyType.hadesGun)
        let wallHades = UInt32(BodyType.wallHades)
        
        if bodyA == zeus && bodyB == hadesGun {
            contact.bodyB.node?.removeFromParent()
            isDeadZeus = true
            nameDeadZeus = contact.bodyA.node?.name ?? ""
        }
        
        if bodyA == hades && bodyB == zeusGun {
            contact.bodyB.node?.removeFromParent()
            isDeadHades = true
            nameDeadHades = contact.bodyA.node?.name ?? ""
        }
        
        if bodyA == wallZeus && bodyB == hadesGun {
            contact.bodyB.node?.removeFromParent()
        }
        
        if bodyA == wallHades && bodyB == zeusGun {
            contact.bodyB.node?.removeFromParent()
        }

        if bodyA == hadesGun && bodyB == zeusGun || bodyB == hadesGun && bodyA == zeusGun {
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.removeFromParent()
        }
        
        if bodyA == zeusGun && bodyB == wallZeus {
            contact.bodyA.node?.removeFromParent()
        }
        
        if bodyA == hadesGun && bodyB == wallHades {
            contact.bodyA.node?.removeFromParent()
        }
        
        if bodyA == wallZeus && bodyB == zeusGun {
            contact.bodyB.node?.removeFromParent()
        }
        
        if bodyA == wallHades && bodyB == hadesGun {
            contact.bodyB.node?.removeFromParent()
        }

    }
}
