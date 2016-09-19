//
//  GameModeSelectScene.swift
//  FindSenpai
//
//  Created by Daniel Young on 2016-05-13.
//  Copyright © 2016 Daniel Young. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class GameModeSelectScene: SKScene {
    var timeAttackLabel = SKLabelNode(fontNamed: "PressStart2P")
    var defaultLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    override func didMoveToView(view: SKView) {
        createLayout()
    }
    
    func createLayout() {
        backgroundColor = SKColor.whiteColor()
        
        // TODO: Adjust frame to make more clickable
        timeAttackLabel.text = "Time Attack!"
        timeAttackLabel.name = "Time"
        timeAttackLabel.fontSize = 25
        timeAttackLabel.fontColor = SKColor.blackColor()
        timeAttackLabel.position = CGPointMake(frame.midX, frame.midY - 30)
        timeAttackLabel.zPosition = 3
        
        // TODO: Adjust frame to make more clickable
        defaultLabel.text = "Casual!"
        defaultLabel.name = "Casual"
        defaultLabel.fontSize = 25
        defaultLabel.fontColor = SKColor.blackColor()
        defaultLabel.position = CGPointMake(frame.midX, frame.midY + 30)
        defaultLabel.zPosition = 3
        
        addChild(timeAttackLabel)
        addChild(defaultLabel)
    }
    
    private func startGame(mode:String) {
        var gameScene:SKScene
        if mode == "Time" {
            gameScene = TimeAttackGameScene(size: view!.bounds.size)
        } else {
            gameScene = GameScene(size: view!.bounds.size)
        }
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        if let name = touchedNode.name
        {
            startGame(name)
        }
    }
}
