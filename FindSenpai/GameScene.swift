//
//  GameScene.swift
//  FindSenpai
//
//  Created by Daniel Young on 2/28/16.
//  Copyright (c) 2016 Daniel Young. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var senpaiNumber : Int!
    var senpaiName : String!
    
    var senpai : SKSpriteNode!
    var senpaiPreview : SKSpriteNode!
    var previewText : SKLabelNode!
    
    var playAreaWidth : CGFloat!
    var playAreaHeight : CGFloat!
    
    func randomNumber(range: Range<Int>) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func scale(number: CGFloat) -> CGFloat {
        return number * CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func setUpPlayArea() {
        backgroundColor = SKColor.whiteColor()
        playAreaWidth = size.width * 0.9;
        playAreaHeight = size.height - 10;
    }
    
    func choseSenpai() {
        senpaiNumber = randomNumber(1...20)
        NSLog("Senpai Number: %d", senpaiNumber)
        senpaiName = "Char" + String(senpaiNumber)
        let senpaiPreviewName = senpaiName + "Big"
        
        senpai = SKSpriteNode(imageNamed: senpaiName);
        senpaiPreview = SKSpriteNode(imageNamed: senpaiPreviewName)
        
        previewText = SKLabelNode(fontNamed: "Arial")
        previewText.text = "Senpai Preview"
        previewText.fontSize = 10
        previewText.fontColor = SKColor.blackColor()
        
        let senpaiX = scale(playAreaWidth)
        let senpaiY = scale(playAreaHeight)
        
        // Set up senpai's position and the position of the preview
        senpai.position = CGPoint(x: senpaiX, y: senpaiY)
        senpaiPreview.position = CGPoint(x: size.width - senpaiPreview.size.width, y: senpaiPreview.size.height)
        previewText.position = CGPoint(x: senpaiPreview.position.x, y: senpaiPreview.size.height + 50)
        
        addChild(senpai)
        addChild(senpaiPreview)
        addChild(previewText)
    }
    
    
    override func didMoveToView(view: SKView) {
        setUpPlayArea()
        choseSenpai()
    }
}
