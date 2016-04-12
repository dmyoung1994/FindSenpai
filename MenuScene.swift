//
//  MenuScene.swift
//  FindSenpai
//
//  Created by Daniel Young on 4/11/16.
//  Copyright © 2016 Daniel Young. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class MenuScene: SKScene {
    var highScore:Int = 0 // Impliment when high score is saved in a DB and change to start at 0
    var title = SKLabelNode(fontNamed: "Arial")
    var playButton = SKLabelNode(fontNamed: "Arial") // find button texture in the future
    
    override func didMoveToView(view: SKView) {
        createLayout()
    }
    
    func createLayout() {
        backgroundColor = SKColor.whiteColor()
        title.text = "Find Senpai"
        title.fontSize = 50
        title.fontColor = SKColor.blackColor()
        title.position = CGPointMake(frame.midX, frame.midY + 50)
        
        playButton.text = "Play!"
        playButton.name = "Play"
        playButton.fontSize = 35
        playButton.fontColor = SKColor.redColor()
        playButton.position = CGPointMake(frame.midX, frame.midY - 20)
        
        addChild(title)
        addChild(playButton)
        
        if (highScore != 0) {
            // add a high score box
        } else {
            // dont add the high score box
            
        }
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
