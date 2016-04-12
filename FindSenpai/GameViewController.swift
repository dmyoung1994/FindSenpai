import UIKit
import SpriteKit

@available(iOS 9.0, *)
class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MenuScene(size: view.bounds.size)
        SKTAudio.sharedInstance().playBackgroundMusic("background.mp3")
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}