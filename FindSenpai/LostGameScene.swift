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
    
    // TODO: Pause and play sad background music
    var lossText:String = "I  DIDN'T WANT YOU"
    var lossText2:String = "TO NOTICE ME ANYWAYS..."
    var playAgainButton:SKLabelNode = SKLabelNode(fontNamed: "PressStart2P")
    var lossLabel:SKLabelNode = SKLabelNode(fontNamed: "PressStart2P")
    var lossLabel2:SKLabelNode = SKLabelNode(fontNamed: "PressStart2P")
    var yourScore:SKLabelNode = SKLabelNode(fontNamed: "PressStart2P")
    var menuButton:SKLabelNode = SKLabelNode(fontNamed: "PressStart2P")
    var contButton:SKLabelNode = SKLabelNode(fontNamed: "PressStart2P")
    var lonelySenpai:SKSpriteNode!
    var gameMode:String!
    
    let highscoreKey = "highScoreKey"
    let highScore = NSUserDefaults.standardUserDefaults()
    
    init(size:CGSize, characterName:String, score:Int, level:Int, mode:String = "Casual") {
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        lonelySenpai = SKSpriteNode(imageNamed: characterName+"Big")
        lonelySenpai.position = CGPoint(x: frame.midX + 150, y: frame.midY)
        
        lossLabel.text = lossText
        lossLabel.fontSize = 15
        lossLabel.position = CGPoint(x: frame.midX - 50, y: frame.midY + 40)
        lossLabel.fontColor = UIColor.blackColor()
        
        lossLabel2.text = lossText2
        lossLabel2.fontSize = 15
        lossLabel2.position = CGPoint(x: frame.midX - 50, y: frame.midY + 10)
        lossLabel2.fontColor = UIColor.blackColor()
        
        // TODO: Adjust frame to make more clickable
        playAgainButton.text = "Play!"
        playAgainButton.name = "Play"
        playAgainButton.fontSize = 25
        playAgainButton.fontColor = UIColor.blackColor()
        playAgainButton.position = CGPoint(x: frame.midX - 80, y: frame.midY - 90)
        
        // TODO: Adjust frame to make more clickable
        contButton.text = "Continue?"
        contButton.name = "Contunue"
        contButton.fontSize = 25
        contButton.fontColor = UIColor.redColor()
        contButton.position = CGPoint(x: frame.midX - 15, y: frame.midY - 40)
        
        // TODO: Adjust frame to make more clickable
        menuButton.text = "Menu"
        menuButton.name = "Menu"
        menuButton.fontSize = 20
        menuButton.fontColor = UIColor.blackColor()
        menuButton.position = CGPoint(x: frame.midX, y: frame.midY - 90)
        
        yourScore.text = "Your Score: " + String(score)
        yourScore.fontSize = 25
        yourScore.fontColor = UIColor.blackColor()
        yourScore.position = CGPoint(x: frame.midX, y: frame.midY + 90)
        
        gameMode = mode
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
        addChild(menuButton)
        addChild(yourScore);
        addChild(contButton);
    }
    
    private func startGame() {
        var gameScene:SKScene
        switch gameMode {
        case "Time":
            gameScene = TimeAttackGameScene(size: view!.bounds.size)
        default:
            gameScene = GameScene(size: view!.bounds.size);
        }
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        if touchedNode.name == "Play" {
            startGame()
        } else if touchedNode.name == "Menu" {
            let menu = MenuScene(size: view!.bounds.size)
            let transition = SKTransition.fadeWithDuration(0.15)
            view!.presentScene(menu, transition: transition)
        }
    }
    
}
