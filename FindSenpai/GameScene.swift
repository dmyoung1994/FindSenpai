//
//  GameScene.swift
//  FindSenpai
//
//  Created by Daniel Young on 2/28/16.
//  Copyright (c) 2016 Daniel Young. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class GameScene: SKScene {
    var senpaiNumber : Int!
    var senpaiName : String!
    var level : Int = 1
    
    var senpai : SKSpriteNode!
    var senpaiPreview : SKSpriteNode!
    var previewText1 : SKLabelNode!
    var previewText2 : SKLabelNode!
    var levelLabel : SKLabelNode!
    var levelDesc : SKLabelNode!
    
    var playAreaWidth : CGFloat!
    var playAreaHeight : CGFloat!
    var heightOffset : Int!
    var widthOffset = 10
    var characterArray : NSMutableArray!
    
    var backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
    
    func randomNumber(range: Range<Int>) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func scale(number: CGFloat) -> Int {
        return randomNumber(0...Int(number))
    }
    
    func setUp() {
        backgroundColor = SKColor.whiteColor()
        playAreaWidth = size.width * 0.8
        playAreaHeight = size.height * 0.8
        heightOffset = Int(size.height - playAreaHeight) / 2
        addChild(backgroundMusic)
    }
    
    func reset() {
        characterArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        for child in self.children as [SKNode] {
            if ((child.name?.containsString("Senpai")) != nil) {
                self.removeChildrenInArray([child])
            }
        }
    }
    
    func generateName(number: NSNumber) -> String {
        return "Char" + String(number)
    }
    
    func choseSenpai() {
        senpaiNumber = randomNumber(1...20)
        characterArray.removeObjectAtIndex(senpaiNumber - 1)
        senpaiName = generateName(senpaiNumber)
        let senpaiPreviewName = senpaiName + "Big"
        
        senpai = SKSpriteNode(imageNamed: senpaiName);
        senpaiPreview = SKSpriteNode(imageNamed: senpaiPreviewName)
        
        let senpaiX = scale(playAreaWidth) + widthOffset
        let senpaiY = scale(playAreaHeight) + heightOffset
        
        // Set up senpai's position and the position of the preview
        senpai.position = CGPoint(x: senpaiX, y: senpaiY)
        senpaiPreview.position = CGPoint(x: size.width - senpaiPreview.size.width, y: (senpaiPreview.size.height / 2) + 10)
        
        senpaiPreview.userInteractionEnabled = true
        senpai.userInteractionEnabled = false
        senpai.name = "Senpai"
        senpaiPreview.name = "SenpaiPreview"
        senpai.zPosition = 2
        
        addChild(senpai)
        addChild(senpaiPreview)
    }
    
    func makeLabels() {
        previewText1 = SKLabelNode(fontNamed: "Arial")
        previewText1.text = "Senpai"
        previewText1.fontSize = 20
        previewText1.fontColor = SKColor.blackColor()
    
        previewText2 = SKLabelNode(fontNamed: "Arial")
        previewText2.text = "Preview"
        previewText2.fontSize = 20
        previewText2.fontColor = SKColor.blackColor()
        
        levelLabel = SKLabelNode(fontNamed: "Arial")
        levelLabel.text = "LEVEL"
        levelLabel.fontSize = 20
        levelLabel.fontColor = SKColor.blackColor()
        
        levelDesc = SKLabelNode(fontNamed: "Arial")
        levelDesc.text = String(level)
        levelDesc.fontSize = 40
        levelDesc.fontColor = SKColor.blackColor()
        
        previewText1.position = CGPoint(x: senpaiPreview.position.x, y: senpaiPreview.size.height + 50)
        previewText2.position = CGPoint(x: senpaiPreview.position.x, y: senpaiPreview.size.height + 30)
        levelLabel.position = CGPoint(x: senpaiPreview.position.x, y: size.height - 40)
        levelDesc.position = CGPoint(x: senpaiPreview.position.x, y: levelLabel.position.y - 40)
        
        previewText1.userInteractionEnabled = true
        previewText2.userInteractionEnabled = true
        levelLabel.userInteractionEnabled = true
        levelDesc.userInteractionEnabled = true
        
        addChild(previewText1)
        addChild(previewText2)
        addChild(levelLabel)
        addChild(levelDesc)
    }
    
    func generateCharacters() {
        let characterSize = 50 * 25
        let numCharacters = Int((playAreaWidth * playAreaHeight) / CGFloat(characterSize * 3)) + level^2
        for _ in 0...numCharacters {
            let randomIndex:Int = Int(arc4random_uniform(UInt32(characterArray.count)))
            let randomNonSenpaiNumber:NSNumber = characterArray[randomIndex] as! NSNumber
            let nonSenpaiName:String = generateName(randomNonSenpaiNumber)
            let nonSenpai:SKSpriteNode = SKSpriteNode(imageNamed: nonSenpaiName)
            
            nonSenpai.position = CGPoint(x: scale(playAreaWidth) + widthOffset, y: scale(playAreaHeight) + heightOffset)
            nonSenpai.name = "NonSenpai"
            nonSenpai.userInteractionEnabled = true
            nonSenpai.zPosition = 1
            
            addChild(nonSenpai);
        }
    }
    
    func updateLevelText() {
        levelDesc.text = String(level)
    }
    
    func newGame() {
        reset()
        choseSenpai()
        generateCharacters()
    }
    
    override func didMoveToView(view: SKView) {
        setUp()
        newGame()
        makeLabels()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        if touchedNode.name == "Senpai" {
            print("Found Senpai")
            level += 1
            updateLevelText()
            newGame()
        } else if touchedNode.name == "NonSenpai" {
            print("WRONG");
        }
    }
}
