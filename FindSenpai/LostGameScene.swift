//
//  LostGameScene.swift
//  FindSenpai
//
//  Created by Daniel Young on 4/22/16.
//  Copyright © 2016 Daniel Young. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class LostGameScene: SKScene {
    
    var lossText:String = "I  didn't  want  you "
    var lossText2:String = "to  notice  me  anyways..."
    var playAgainButton:SKLabelNode = SKLabelNode(fontNamed: "ArcadeClassic")
    var lossLabel:SKLabelNode = SKLabelNode(fontNamed: "ArcadeClassic")
    var lossLabel2:SKLabelNode = SKLabelNode(fontNamed: "ArcadeClassic")
    var yourScore:SKLabelNode = SKLabelNode(fontNamed: "ArcadeClassic")
    var lonelySenpai:SKSpriteNode!
    
    init(size: CGSize, characterName:String, score:Int) {
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        lonelySenpai = SKSpriteNode(imageNamed: characterName+"Big")
        lonelySenpai.position = CGPoint(x: frame.midX + 120, y: frame.midY)
        
        lossLabel.text = lossText
        lossLabel.fontSize = 25
        lossLabel.position = CGPoint(x: frame.midX - 50, y: frame.midY + 40)
        lossLabel.fontColor = UIColor.blackColor()
        
        lossLabel2.text = lossText2
        lossLabel2.fontSize = 25
        lossLabel2.position = CGPoint(x: frame.midX - 50, y: frame.midY + 10)
        lossLabel2.fontColor = UIColor.blackColor()
        
        playAgainButton.text = "Play Again!"
        playAgainButton.name = "Play"
        playAgainButton.fontSize = 40
        playAgainButton.fontColor = UIColor.redColor()
        playAgainButton.position = CGPoint(x: frame.midX - 50, y: frame.midY - 50)
        
        yourScore.text = "Your Score: " + String(score)
        yourScore.fontSize = 40
        yourScore.fontColor = UIColor.blackColor()
        yourScore.position = CGPoint(x: frame.midX, y: frame.midY + 90)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        // Setup base scene
        createLayout()
    }
    
    func createLayout() {
        addChild(lossLabel)
        addChild(lonelySenpai)
        addChild(lossLabel2)
        addChild(playAgainButton)
    }
    
    private func startGame() {
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        if touchedNode.name == "Play" {
            startGame()
        }
    }
    
}
