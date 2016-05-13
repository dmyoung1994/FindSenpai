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
    var timeAttackLabel = SKLabelNode(fontNamed: "ArcadeClassic")
    var defaultLabel = SKLabelNode(fontNamed: "ArcadeClassic")
    
    override func didMoveToView(view: SKView) {
        createLayout()
    }
    
    func createLayout() {
        backgroundColor = SKColor.whiteColor()
        
        timeAttackLabel.text = "Time Attack!"
        timeAttackLabel.name = "Time"
        timeAttackLabel.fontSize = 40
        timeAttackLabel.fontColor = SKColor.blackColor()
        timeAttackLabel.position = CGPointMake(frame.midX - 150, frame.midY)
        timeAttackLabel.zPosition = 3
        
        defaultLabel.text = "Casual!"
        defaultLabel.name = "Casual"
        defaultLabel.fontSize = 40
        defaultLabel.fontColor = SKColor.blackColor()
        defaultLabel.position = CGPointMake(frame.midX + 150, frame.midY)
        defaultLabel.zPosition = 3
        
        addChild(timeAttackLabel)
        addChild(defaultLabel)
    }
    
    private func startGame(mode:String) {
        var gameScene:SKScene
        switch mode {
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
        let nodeNade = (touchedNode.name != nil) ? touchedNode.name! : ""
        startGame(nodeNade)
    }
}
