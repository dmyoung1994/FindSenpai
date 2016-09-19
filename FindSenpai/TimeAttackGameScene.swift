//
//  TimeAttackGameScene.swift
//  FindSenpai
//
//  Created by Daniel Young on 2016-05-13.
//  Copyright © 2016 Daniel Young. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class TimeAttackGameScene: SKScene {
    var senpaiNumber : Int!
    var senpaiName : String!
    
    var level = 1
    var difficulty = 1.5
    var widthOffset = 10
    var characterSize = 50 * 25
    var numCharacters = 1
    var score = 0
    
    var timeForLevel = 20.0
    let timeInterval:NSTimeInterval = 0.05
    var timeCount:NSTimeInterval = 30.0
    
    var senpai : CharacterNode!
    var senpaiPreview : SKSpriteNode!
    var previewText1 : SKLabelNode!
    var previewText2 : SKLabelNode!
    var timerLabel : SKLabelNode!
    var timerDesc : SKLabelNode!
    var scoreText : SKLabelNode!
    
    var playAreaWidth : CGFloat!
    var playAreaHeight : CGFloat!
    var heightOffset : Int!
    var characterArray : NSMutableArray!
    var levelReward = SKSpriteNode(imageNamed: "reward")
    
    var levelStart : NSDate!
    var levelEnd : NSDate!
    
    var timer : NSTimer!
    
    func randomNumber(range: Range<Int>) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func scale(number: CGFloat) -> Int {
        return randomNumber(0...Int(number))
    }
    
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10.0))
    }
    
    func timerDidEnd(){
        timeCount = timeCount - timeInterval
        if timeCount <= 10 {
            timerDesc.fontColor = SKColor.redColor()
        }
        if timeCount <= 0 {
            // Game is lost
            endGame()
        } else {
            timerDesc.text = timeString(timeCount)
        }
    }
    
    func setUp() {
        backgroundColor = SKColor.whiteColor()
        
        playAreaWidth = size.width * 0.8
        playAreaHeight = size.height * 0.8
        heightOffset = Int(size.height - playAreaHeight) / 2
        
        levelReward.size = CGSize(width: (levelReward.size.width / 6), height: (levelReward.size.height / 6))
        levelReward.alpha = 0.0
        levelReward.zPosition = 3
        levelReward.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        numCharacters = Int((playAreaWidth * playAreaHeight) / CGFloat(characterSize * 5))
        timer = NSTimer()
        addChild(levelReward)
    }
    
    func reset() {
        characterArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        for child in self.children as [SKNode] {
            if ((child.name?.containsString("Senpai")) != nil) {
                self.removeChildrenInArray([child])
            }
        }
        
        levelStart = NSDate()
    }
    
    func generateName(number: NSNumber) -> String {
        return "Char" + String(number)
    }
    
    func choseSenpai() {
        senpaiNumber = randomNumber(1...20)
        characterArray.removeObjectAtIndex(senpaiNumber - 1)
        senpaiName = generateName(senpaiNumber)
        let senpaiPreviewName = senpaiName + "Big"
        
        senpai = CharacterNode(imageNamed: senpaiName, areaHeight: size.height - 20, areaWidth: size.width, name: "Senpai", zPos: 2, level: level)
        senpaiPreview = SKSpriteNode(imageNamed: senpaiPreviewName)
        
        // Set up position of the preview
        senpaiPreview.position = CGPoint(x: size.width * 0.9, y: (senpaiPreview.size.height / 2) + 10)
        
        senpaiPreview.userInteractionEnabled = true
        senpaiPreview.name = "SenpaiPreview"
        
        addChild(senpai)
        addChild(senpaiPreview)
    }
    
    func animateReward() {
        let fadeIn = SKAction.fadeInWithDuration(0)
        let scaleUp = SKAction.scaleTo(2, duration: 0.5)
        let fadeOut = SKAction.fadeOutWithDuration(0.5)
        let scaleDown = SKAction.scaleTo(1, duration: 0)
        let sequecnce = SKAction.sequence([fadeIn, scaleUp, fadeOut, scaleDown])
        levelReward.runAction(sequecnce)
    }
    
    func makeLabels() {
        previewText1 = SKLabelNode(fontNamed: "PressStart2P")
        previewText1.text = "Senpai"
        previewText1.fontSize = 15
        previewText1.fontColor = SKColor.blackColor()
        
        previewText2 = SKLabelNode(fontNamed: "PressStart2P")
        previewText2.text = "Preview"
        previewText2.fontSize = 15
        previewText2.fontColor = SKColor.blackColor()
        
        timerLabel = SKLabelNode(fontNamed: "PressStart2P")
        timerLabel.text = "Time"
        timerLabel.fontSize = 20
        timerLabel.fontColor = SKColor.blackColor()
        
        timerDesc = SKLabelNode(fontNamed: "PressStart2P")
        timerDesc.text = timeString(timeCount)
        timerDesc.fontSize = 15
        timerDesc.fontColor = SKColor.blackColor()
        
        scoreText = SKLabelNode(fontNamed: "PressStart2P")
        scoreText.text = "Score: " + String(score)
        scoreText.fontSize = 15
        scoreText.fontColor = SKColor.blackColor()
        scoreText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        previewText1.position = CGPoint(x: senpaiPreview.position.x, y: senpaiPreview.size.height + 60)
        previewText2.position = CGPoint(x: senpaiPreview.position.x, y: senpaiPreview.size.height + 40)
        timerLabel.position = CGPoint(x: senpaiPreview.position.x, y: size.height - 40)
        timerDesc.position = CGPoint(x: senpaiPreview.position.x, y: timerLabel.position.y - 40)
        scoreText.position = CGPoint(x: 10, y: size.height - 20)
        
        previewText1.userInteractionEnabled = true
        previewText2.userInteractionEnabled = true
        timerLabel.userInteractionEnabled = true
        timerDesc.userInteractionEnabled = true
        scoreText.userInteractionEnabled = true
        
        addChild(previewText1)
        addChild(previewText2)
        addChild(timerLabel)
        addChild(timerDesc)
        addChild(scoreText)
    }
    
    func generateCharacters() {
        let chars = Int(CGFloat(numCharacters) * (1 + (CGFloat(level) * 0.1)))
        for _ in 0...chars {
            let randomIndex:Int = Int(arc4random_uniform(UInt32(characterArray.count)))
            let randomNonSenpaiNumber:NSNumber = characterArray[randomIndex] as! NSNumber
            let nonSenpaiName:String = generateName(randomNonSenpaiNumber)
            let nonSenpai = CharacterNode(imageNamed: nonSenpaiName, areaHeight: size.height - 20, areaWidth: size.width, name: nonSenpaiName, zPos: 1, level: level)
            
            addChild(nonSenpai);
        }
    }
    
    func calculateScore() {
        levelEnd = NSDate()
        let maxScore:Double = Double(level) * 10
        let levelDuration = Int(levelEnd.timeIntervalSinceDate(levelStart))
        if levelDuration < 10 {
            score += Int(maxScore)
        } else if levelDuration < 20 {
            score += Int(maxScore * 0.8)
        } else if levelDuration < 30 {
            score += Int(maxScore * 0.6)
        } else {
            score += Int(maxScore * 0.3)
        }
    }
    
    func updateLevelText() {
        calculateScore()
        timer.invalidate()
        level += 1
        scoreText.text = "Score: " + String(score)
        timeCount = timeCount + timeForLevel
        timerDesc.text = timeString(timeCount)
        timerDesc.fontColor = SKColor.blackColor()
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
                                                       target: self,
                                                       selector: #selector(TimeAttackGameScene.timerDidEnd),
                                                       userInfo: nil,
                                                       repeats: true)
    }
    
    func newGame() {
        reset()
        choseSenpai()
        generateCharacters()
        startTimer()
    }
    
    func nextLevel() {
        animateReward()
        updateLevelText()
        newGame()
    }
    
    func endGame() {
        timer.invalidate()
        let scene = LostGameScene(size: size, characterName: senpaiName!, score: score, level: level, mode: "Time")
        let transition = SKTransition.fadeWithDuration(0.5)
        self.view!.presentScene(scene, transition: transition)
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
            nextLevel()
        } else if ((touchedNode.name?.containsString("Char")) != nil) {
            endGame()
        }
    }
}
