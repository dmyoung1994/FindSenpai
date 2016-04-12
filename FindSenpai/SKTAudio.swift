//
//  SKTAudio.swift
//  FindSenpai
//
//  Created by Daniel Young on 4/11/16.
//  Copyright © 2016 Daniel Young. All rights reserved.
//

import AVFoundation

/**
 * Audio player that uses AVFoundation to play looping background music and
 * short sound effects. For when using SKActions just isn't good enough.
 */
public class SKTAudio {
    public var backgroundMusicPlayer: AVAudioPlayer?
    public var soundEffectPlayer: AVAudioPlayer?
    
    public class func sharedInstance() -> SKTAudio {
        return SKTAudioInstance
    }
    
    public func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: url!)
        } catch let error1 as NSError {
            error = error1
            backgroundMusicPlayer = nil
        }
        if let player = backgroundMusicPlayer {
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } else {
            print("Could not create audio player: \(error!)")
        }
    }
    
    public func pauseBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if player.playing {
                player.pause()
            }
        }
    }
    
    public func resumeBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if !player.playing {
                player.play()
            }
        }
    }
    
    public func playSoundEffect(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOfURL: url!)
        } catch let error1 as NSError {
            error = error1
            soundEffectPlayer = nil
        }
        if let player = soundEffectPlayer {
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        } else {
            print("Could not create audio player: \(error!)")
        }
    }
}

private let SKTAudioInstance = SKTAudio()