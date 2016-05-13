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
    var title = SKLabelNode(fontNamed: "ArcadeClassic")
    var playButton = SKLabelNode(fontNamed: "ArcadeClassic") // find button texture in the future
    
    override func didMoveToView(view: SKView) {
        createLayout()
    }
    
    func createLayout() {
        backgroundColor = SKColor.whiteColor()
        title.text = "Find Senpai"
        title.fontSize = 50
        title.fontColor = SKColor.blackColor()
        title.position = CGPointMake(frame.midX, frame.midY + 50)
        title.zPosition = 3
        
        playButton.text = "Play!"
        playButton.name = "Play"
        playButton.fontSize = 35
        playButton.fontColor = SKColor.redColor()
        playButton.position = CGPointMake(frame.midX, frame.midY - 20)
    
        playButton.zPosition = 3
        
        addChild(title)
        addChild(playButton)
        
        for i in 1...20 {
            let name = "Char" + String(i)
            let charNode = CharacterNode(imageNamed: name, areaHeight: size.height, areaWidth: size.width, name: "menuChar", zPos: 1, level: 1)
            addChild(charNode)
        }
        
        if (highScore != 0) {
            // add a high score box
        } else {
            // dont add the high score box
            
        }
    }
    
    private func selectMode() {
        let modeSelect = GameModeSelectScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(modeSelect, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        if touchedNode.name == "Play" {
            selectMode()
        }
    }
}
