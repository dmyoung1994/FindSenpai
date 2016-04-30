//
//  CharacterNode.swift
//  FindSenpai
//
//  Created by Daniel Young on 4/10/16.
//  Copyright © 2016 Daniel Young. All rights reserved.
//

import UIKit
import SpriteKit


/*      1
 *  4      2
 *      3
 */
let positions = [1,2,3,4]


class CharacterNode: SKSpriteNode {
    var start:Int!
    var currentPos:Int!
    var height:CGFloat!
    var width:CGFloat!
    var offset = CGFloat(25)
    var difficulty:Double = 7
    var level:Int!
    
    func randomPosition()-> Int {
        return positions[Int(arc4random_uniform(UInt32(4)))]
    }
    
    func randomNumber(range: Range<Int>) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func scale(number: CGFloat, startingAt start:CGFloat) -> Int {
        return randomNumber(Int(offset)...Int(number))
    }
    
    init(imageNamed image:String, areaHeight height1:CGFloat, areaWidth width1:CGFloat, name nodeName:String, zPos pos:Int, level lvl:Int) {
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        start = randomPosition()
        height = height1 - offset
        width = width1 * 0.8
        if nodeName == "menuChar" {
            width = width1 - offset
        }
        alpha = 0.0
        currentPos = start
        userInteractionEnabled = false
        name = nodeName
        zPosition = CGFloat(pos)
        level = lvl
        
        switch (start) {
        case 1:
            self.position = CGPoint(x: CGFloat(scale(width, startingAt: offset)), y: height)
            break
        case 2:
            self.position = CGPoint(x: width, y: CGFloat(scale(height, startingAt: offset)))
            break
        case 3:
            self.position = CGPoint(x: CGFloat(scale(width, startingAt: offset)), y: offset)
            break
        case 4:
            self.position = CGPoint(x: offset, y: CGFloat(scale(height, startingAt: offset)))
            break
        default:
            NSLog("SHOULDNT BE HERE (start)")
            break
        }
        
        setTimeout(Double(randomNumber(0...8)), block: { () -> Void in
            self.moveCharacter()
        })
    }
    
    func setTimeout(interval:NSTimeInterval, block:()->Void) -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(interval, target: NSBlockOperation(block: block), selector: #selector(NSOperation.main), userInfo: nil, repeats: false)
    }
    
    func adjustDifficulty(level:Int) {
        if difficulty < 3 {
            difficulty = 3
        } else {
            difficulty = difficulty - (Double(level) / 10)
        }
    }
    
    func randomizeXPos() {
        self.position = CGPoint(x: CGFloat(scale(width, startingAt: offset)), y: self.position.y)
    }
    
    func randomizeYPos() {
        self.position = CGPoint(x: self.position.y, y: CGFloat(scale(height, startingAt: offset)))
    }
    
    func moveCharacter() {
        let fadeIn = SKAction.fadeInWithDuration(0.2)
        let fadeOut = SKAction.fadeOutWithDuration(0.2)
        let move:SKAction!
        switch (currentPos) {
        case 1:
            move = SKAction.moveToY(offset, duration: difficulty)
            if difficulty < 5.5 {randomizeXPos()}
            currentPos = 3
            break
        case 2:
            move = SKAction.moveToX(offset, duration: difficulty)
            if difficulty < 5.5 {randomizeYPos()}
            currentPos = 4
            break
        case 3:
            move = SKAction.moveToY(height, duration: difficulty)
            if difficulty < 5.5 {randomizeXPos()}
            currentPos = 1
            break
        case 4:
            move = SKAction.moveToX(width, duration: difficulty)
            if difficulty < 5.5 {randomizeYPos()}
            currentPos = 2
            break
        default:
            move = SKAction()
            NSLog("SHOULDNT BE HERE (move)")
            break
        }
        self.runAction(SKAction.sequence([fadeIn, move, fadeOut]))
        setTimeout(difficulty + Double(randomNumber(0...10)), block: { () -> Void in
            self.moveCharacter()
        })
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
