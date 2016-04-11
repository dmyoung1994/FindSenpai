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
let animateDuration = NSTimeInterval(2)


class CharacterNode: SKSpriteNode {
    var start:Int!
    var currentPos:Int!
    var height:CGFloat!
    var width:CGFloat!
    var heightOffset:Int!
    var offset = CGFloat(25)
    
    func randomPosition()-> Int {
        return positions[Int(arc4random_uniform(UInt32(4)))]
    }
    
    func randomNumber(range: Range<Int>) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func scale(number: CGFloat) -> Int {
        return randomNumber(0...Int(number))
    }
    
    init(imageNamed image:String, areaHeight height1: CGFloat, areaWidth width1: CGFloat, name nodeName: String, zPos pos: Int) {
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        start = randomPosition()
        height = height1 - offset
        width = width1 * 0.8
        heightOffset = Int(height1 - height) / 2
        alpha = 0.0
        currentPos = start
        userInteractionEnabled = false
        name = nodeName
        zPosition = CGFloat(pos)
        
        switch (start) {
        case 1:
            self.position = CGPoint(x: CGFloat(scale(width)) + offset, y: height)
            break
        case 2:
            self.position = CGPoint(x: width, y: CGFloat(scale(height) + heightOffset))
            break
        case 3:
            self.position = CGPoint(x: CGFloat(scale(width)) + offset, y: offset)
            break
        case 4:
            self.position = CGPoint(x: offset, y: CGFloat(scale(height) + heightOffset))
            break
        default:
            NSLog("SHOULDNT BE HERE (start)")
            break
        }
        
        setInterval(Double(3 + randomNumber(0...10)), block: { () -> Void in
            self.moveCharacter()
        })
    }
    
    func setInterval(interval:NSTimeInterval, block:()->Void) -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(interval, target: NSBlockOperation(block: block), selector: #selector(NSOperation.main), userInfo: nil, repeats: true)
    }
    
    func moveCharacter() {
        let fadeIn = SKAction.fadeInWithDuration(0.2)
        let fadeOut = SKAction.fadeOutWithDuration(0.2)
        let move:SKAction!
        switch (currentPos) {
        case 1:
            move = SKAction.moveToY(offset, duration: animateDuration)
            currentPos = 3
            break
        case 2:
            move = SKAction.moveToX(offset, duration: animateDuration)
            currentPos = 4
            break
        case 3:
            move = SKAction.moveToY(height, duration: animateDuration)
            currentPos = 1
            break
        case 4:
            move = SKAction.moveToX(width, duration: animateDuration)
            currentPos = 2
            break
        default:
            move = SKAction()
            NSLog("SHOULDNT BE HERE (move)")
            break
        }
        self.runAction(SKAction.sequence([fadeIn, move, fadeOut]))
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
