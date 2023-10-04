//
//  GlobalFunctions.swift
//  SoloMission
//
//  Created by Derek Harrison on 04/10/2023.
//

import Foundation
import SpriteKit

func play_sound_api(scene : SKScene, sound : [SKAction]) {
    let bubble_sound = SKSpriteNode()
    scene.addChild(bubble_sound)

    let bubble_sound_biteSequence = SKAction.sequence(sound)
    bubble_sound.run(bubble_sound_biteSequence)
}

func get_rand_num() -> CGFloat {
    CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}

func doOverlap(l1: CGPoint ,r1: CGPoint, l2: CGPoint, r2: CGPoint) -> Bool {
 
    // At least one of the rectangles is a line
    if (l1.x == r1.x || l1.y == r1.y || l2.x == r2.x
        || l2.y == r2.y) {
        return false;
    }
 
    // If one rectangle is on left side of other
    if (l1.x >= r2.x || l2.x >= r1.x) {
        return false;
    }
 
    // If one rectangle is above other
    if (r1.y >= l2.y || r2.y >= l1.y) {
        return false;
    }
 
    return true
}

func check_collision(bird : GameObject, player : Player, den : CGFloat) -> Bool {
    
    var l1 = bird.images[0].position
    var r1 = l1
    l1.x -= bird.get_size().width / den
    l1.y += bird.get_size().height / den
    r1.x += bird.get_size().width / den
    r1.y -= bird.get_size().height / den
    var l2 = player.images[0].position
    var r2 = player.images[0].position
    l2.x -= player.images[0].size.width / den
    l2.y += player.images[0].size.height / den
    r2.x += player.images[0].size.width / den
    r2.y -= player.images[0].size.height / den
                    
    return doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
}
