//
//  GameObject.swift
//  SoloMission
//
//  Created by Derek Harrison on 24/09/2023.
//

import Foundation
import SpriteKit

enum gameState {
    case preGame
    case inGame
    case afterGame
    case gamePaused
}

class Bubbles {
    
    var bubbles : [SKSpriteNode]
    var bubcounter : Int
    
    init() {
        self.bubbles = [SKSpriteNode]()
        self.bubcounter = 1
    }
    
    func add_bubble(image_id : String) {
        
        self.bubbles.append(SKSpriteNode(imageNamed: image_id))
    }
    
    func play_bubbles() {
        bubcounter = 1
        for x in bubbles {
            x.zPosition = -1
        }
    }
    
    func set_pos_bubbles(pos : CGPoint) {
        for x in bubbles {
            x.position = pos
        }
    }

    func pop_bubbles_api(pos : CGPoint, scene : SKScene, sound : [SKAction]) {
        
        if self.bubcounter == 1 {
            self.bubbles[0].position = pos
            self.bubbles[0].zPosition = 1000
            self.bubcounter += 1
            play_sound_api(scene : scene, sound : sound)
            
        }
        else if self.bubcounter < 40 {
            self.bubbles[0].position.y += bubble_vel_y
            self.bubcounter += 1
        }
        else if bubcounter == 40 {
            self.bubbles[1].position = pos
            self.bubbles[1].zPosition = 1000
            self.bubcounter += 1
        }
        else if bubcounter < 80 {
            self.bubbles[0].position.y += bubble_vel_y
            self.bubbles[1].position.y += bubble_vel_y
            self.bubcounter += 1
        }
        else if self.bubcounter == 80 {
            self.bubbles[2].position = pos
            self.bubbles[2].zPosition = 1000
            self.bubcounter += 1
        }
        else if self.bubcounter < 240 {
            self.bubbles[0].position.y += bubble_vel_y
            self.bubbles[1].position.y += bubble_vel_y
            self.bubbles[2].position.y += bubble_vel_y
            self.bubcounter += 1
        }
        if self.bubcounter == 240 {
            play_bubbles()
        }
    }
}

class Player : GameObject {
    
    override init() { super.init() }
    
    init(images : [String], size : CGSize, z_pos : CGFloat) {
        super.init()
        
        for x in images {
            self.add_image(image: x)
        }
        
        self.set_pos(pos: CGPoint(x: -5000, y: 0))
        self.set_z_pos(z_pos: z_pos)
        self.set_size(size: size)
    }
    
    func add_image_hit(image : String, size : CGSize, z_pos : CGFloat) {
        self.image_hit = SKSpriteNode(imageNamed: image)
        self.image_hit.size = size
        self.image_hit.zPosition = z_pos
    }
    
    func update_pos_api() {
        self.update_pos3()
    }
    
    func set_pos_api(pos : CGPoint) {
        self.set_pos(pos: pos)
        self.image_hit.position = pos
    }
}

class Bird : GameObject {
    
    override init() { super.init() }
    
    init(birds : [String], size : CGSize, z_pos : CGFloat) {
        super.init()
        
        for x in birds {
            self.add_image(image: x)
        }
        
        self.set_pos(pos: CGPoint(x: -5000, y: 0))
        self.set_z_pos(z_pos: z_pos)
        self.set_size(size: size)
    }
}

class JellyFish : GameObject {
    
    var counter : Int = 1
    
    init(jelly_fish : [String], size : CGSize, z_pos : CGFloat) {
        super.init()
        
        for x in jelly_fish {
            self.add_image(image: x)
        }
        
        self.set_pos(pos: CGPoint(x: -5000, y: 0))
        self.set_z_pos(z_pos: z_pos)
        self.set_size(size: size)
    }

    func update_pos_api() {
        
        if counter < 20 {
            for x in images {
                x.position.y += 2
            }
            counter += 1
        }
        else if counter < 40 {
            for x in images {
                x.position.y -= 2
            }
            counter += 1
        }
        else if counter == 40 {
            counter = 1
        }
    }
}


class Brownie : GameObject {
    
    override init() { super.init() }
    
    func update_pos_api(scene : SKScene) {
        
        self.reflect(scene : scene)
        self.update_pos(scene : scene, at_screen : 3)
        
        if hit {
            self.birdi_on_top(image_id: 1)
        }
        
        if !hit {
            self.birdi_on_top(image_id: 0)
        }
        
        self.appeared = self.images[0].position.x > 0 && self.images[0].position.x < scene.size.width
    }
    
}

class Frito : GameObject {
    override init() { super.init() }
    
    func update_pos_api(scene : SKScene) {
        
        self.reflect(scene : scene)
        self.update_pos(scene : scene, at_screen : 3)
        
        if hit {
            self.birdi_on_top(image_id: 1)
        }
        
        if !hit {
            self.birdi_on_top(image_id: 0)
        }
        
        self.appeared = self.images[0].position.x > 0 && self.images[0].position.x < scene.size.width
    }
}

class Snack : GameObject {
    var points_snack : Int
    
    init(bite : String, points : Int, size : CGSize, z_pos : CGFloat) {
        self.points_snack = points
        super.init()
        self.add_image(image: bite)
        
        let factor = 1.0 - (self.images[0].size.height) / (self.height / 2)
        let pos_x = get_rand_num() * self.width * 2
        let pos_y = get_rand_num() * self.height / 2 * factor + self.height / 4 + 1/2 * (1 - factor) * self.height / 2
        
        self.set_pos(pos: CGPoint(x: pos_x, y: pos_y))
        self.set_z_pos(z_pos: z_pos)
        self.set_size(size: size)
    }
}

class Misty : GameObject {
    var top : Bool
    var counter1 = 1000
    var counter2 = 1000
    
    override init() {
        self.top = true
        super.init()
        self.height = 100000
        self.width = -100000
        self.set_pos(pos: CGPoint(x: -5000, y: 0))
    }
    
    func play_misty(bool : Bool) {
        self.counter1 = 1;
        self.counter2 = 1;
        
        self.top = bool
    }
    
    func set_vel_misty(vx : CGFloat, vy : CGFloat) {
        self.set_vel(vel_x: vx, vel_y: vy)
    }
    
    func pop_misty(height : CGFloat, speed : CGFloat) {
        
        if !self.hit && top {
            self.birdi_on_top(image_id: 2)
        }
        
        if self.hit && top {
            self.birdi_on_top(image_id: 3)
        }
        
        if !self.hit && !top {
            self.birdi_on_top(image_id: 0)
        }
        
        if self.hit && !top {
            self.birdi_on_top(image_id: 1)
        }
        
        if counter1 < 60 {
            self.update_pos()
            counter1 += 1
        }
        
        else if counter1 == 60 {
            self.vel_y = -self.vel_y
            counter1 += 1
        }
        
        else if counter1 < 120 {
            self.update_pos()
            counter1 += 1
        }
    }
}

class BlowFish : GameObject {
    
    override init() {
        super.init()
    }
    
    func update_pos_api(scene : SKScene, bk_speed : CGFloat) {
        
        if !self.hit {
            self.update_pos(scene: scene, bk_speed: bk_speed)
        }
        else {
            self.update_pos_hit(scene : scene, bk_speed : bk_speed)
        }
    }
}

class GameObject {
    var z_pos: CGFloat
    var vel_x: CGFloat
    var vel_y: CGFloat
    var play_sound: Bool
    var play_hit_sound : Bool
    var images : [SKSpriteNode]
    var image : SKSpriteNode
    var image_hit : SKSpriteNode
    var images_hit : [SKSpriteNode]
    var image_names : [String]
    var bird_counter = 1
    var bird_counter_hit = 1
    var bird_id = 0
    var bird_id_hit = 0
    var width : CGFloat
    var height : CGFloat
    var hit : Bool
    var appeared : Bool
    var bubbles : Bubbles
    
    init() {
        self.z_pos = -1
        self.vel_x = 0
        self.vel_y = 0
        self.play_sound = true
        self.play_hit_sound = true
        self.images = [SKSpriteNode]()
        self.image = SKSpriteNode()
        self.image_hit = SKSpriteNode()
        self.images_hit = [SKSpriteNode]()
        self.image_names = [String]()
        self.width = 0
        self.height = 0
        self.hit = false
        self.appeared = false
        self.bubbles = Bubbles()
    }
    
    func set_height(height : CGFloat) {
        self.height = height
    }
    
    func set_width(width : CGFloat) {
        self.width = width
    }
    
    func set_z_pos(z_pos : CGFloat) {
        self.z_pos = z_pos
        for image in images {
            image.zPosition = z_pos
        }
        for image in images_hit {
            image.zPosition = z_pos
        }
    }
    
    func update_pos() {
        for image in images {
            image.position.x += self.vel_x
            image.position.y += self.vel_y
        }
        for image in images_hit {
            image.position = images[0].position
        }
    }
    
    func set_pos(pos : CGPoint) {
        for image in images {
            image.position = pos
        }
        for image in images_hit {
            image.position = pos
        }
    }
    
    func get_pos() -> CGPoint {
        return self.images[0].position
    }
    
    func set_vel(vel_x : CGFloat, vel_y : CGFloat) {
        self.vel_x = vel_x
        self.vel_y = vel_y
    }
    
    func set_play_sound(play_s : Bool) {
        self.play_sound = play_s
    }
    
    func set_image(image : SKSpriteNode) {
        self.image = image
    }
    
    func set_image_hit(image : SKSpriteNode) {
        self.image_hit = image
    }
    
    func get_image() -> SKSpriteNode {
        
        return self.image
    }
    
    func get_image_hit() -> SKSpriteNode {
        
        return self.image_hit
    }
    
    func add_image(image : String) {
        self.images.append(SKSpriteNode(imageNamed: image))
        self.image_names.append(image)
    }
    
    func add_image_hit(image : String) {
        self.images_hit.append(SKSpriteNode(imageNamed: image))
    }
    
    func add_childs(scene : SKScene) {
        for x in self.images {
            x.removeFromParent()
            scene.addChild(x)
        }
        for x in self.images_hit {
            x.removeFromParent()
            scene.addChild(x)
        }
        self.image_hit.removeFromParent()
        scene.addChild(self.image_hit)
    }
    
    func birdi_on_top(image_id : Int) {
        for image in 0..<self.images.count {
            if(image == image_id) {
                self.images[image].zPosition = self.z_pos
            }
            else {
                self.images[image].zPosition = -1
            }
        }
        for image in 0..<self.images_hit.count {
            self.images_hit[image].zPosition = -1
        }
    }
    
    func birdi_on_top_hit(image_id : Int) {
        for image in 0..<self.images_hit.count {
            if(image == image_id) {
                self.images_hit[image].zPosition = self.z_pos
            }
            else {
                self.images_hit[image].zPosition = -1
            }
        }
        for image in 0..<self.images.count {
            self.images[image].zPosition = -1
        }
    }
    
    func set_z_pos_api(z_pos : CGFloat) {
        self.set_z_pos(z_pos: z_pos)
    }
    
    func set_z_pos(image : SKSpriteNode, z_pos : CGFloat) {
        self.image.zPosition = z_pos
    }
    
    func set_size(size : CGSize) {
        for x in self.images {
            x.size = size
        }
    }
    
    func get_size() -> CGSize {
        return self.images[0].size
    }
    
    func reflect(scene : SKScene) {
        if self.images[0].position.y < 0.25 * scene.size.height {
            self.images[0].position.y = 0.25 * scene.size.height
            self.vel_y = -self.vel_y
        }
        if self.images[0].position.y > 0.75 * scene.size.height {
            self.images[0].position.y = 0.75 * scene.size.height
            self.vel_y = -self.vel_y
        }
    }
    
    func update_pos(scene : SKScene, bk_speed : CGFloat) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            let speed = get_rand_num() * 2 * bk_speed + 1.2 * bk_speed
            set_vel(vel_x: speed, vel_y: 0)
            
            self.play_sound = true
            self.play_hit_sound = true
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
            
            self.hit = false
        }
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        for x in self.images_hit {
            x.position = self.images[0].position
        }
        
        advance_bird_counter()
    }
    
    func update_pos_rev(scene : SKScene, bk_speed : CGFloat) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x - self.images[0].size.width > self.width {
            
            let speed = get_rand_num() * 2 * bk_speed + 1.2 * bk_speed
            set_vel(vel_x: speed, vel_y: 0)
            
            self.play_sound = true
            self.play_hit_sound = true
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = -get_rand_num() * scene.size.width - scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
            
            self.hit = false
        }
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        for x in self.images_hit {
            x.position = self.images[0].position
        }
        
        advance_bird_counter()
    }
    func update_pos_hit(scene : SKScene, bk_speed : CGFloat) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            let speed = get_rand_num() * 2 * bk_speed + 1.2 * bk_speed
            set_vel(vel_x: speed, vel_y: 0)
            
            self.play_sound = true
            self.play_hit_sound = true
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
            
            self.hit = false
        }
        
        for x in self.images_hit {
            x.position = self.images[0].position
        }
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        advance_bird_counter_hit()
    }
    
    func reflect_player_velocity() {
        if self.images[0].position.x < 0 {
            self.images[0].position.x = 0
            self.vel_x = -self.vel_x
        }
        if self.images[0].position.x > self.width {
            self.images[0].position.x = self.width
            self.vel_x = -self.vel_x
        }
        if self.images[0].position.y > (self.height / 2 + self.height / 4) {
            self.images[0].position.y = self.height / 2 + self.height / 4
            self.vel_y = -self.vel_y
        }
        if self.images[0].position.y < (self.height / 2 - self.height / 4) {
            self.images[0].position.y = self.height / 2 - self.height / 4
            self.vel_y = -self.vel_y
        }
    }
    
    func update_pos3() {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        reflect_player_velocity()
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        self.image_hit.position = self.images[0].position
        
        advance_bird_counter()
    }
    
    func update_pos(scene : SKScene) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            self.play_sound = true
            self.play_hit_sound = true
            self.hit = false
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor  + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
        }
        for x in self.images {
            x.position = self.images[0].position
        }
    }
    
    func update_pos(scene : SKScene, at_screen : Int) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            self.play_sound = true
            self.play_hit_sound = true
            self.hit = false
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + CGFloat(at_screen) * scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor  + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
        }
        for x in self.images {
            x.position = self.images[0].position
        }
        
        advance_bird_counter()
    }
    
    func advance_bird_counter() {
        bird_counter += 1
        
        if(bird_counter < num_frames_bird) {
            birdi_on_top(image_id: bird_id)
        }
        else {
            bird_counter = 0
            bird_id += 1
            if(bird_id == self.images.count) { bird_id = 0 }
            birdi_on_top(image_id: bird_id)

        }
    }
    
    func advance_bird_counter_hit() {
        bird_counter_hit += 1
        
        if(bird_counter_hit < num_frames_bird) {
            birdi_on_top_hit(image_id: bird_id_hit)
        }
        else {
            bird_counter_hit = 0
            bird_id_hit += 1
            if(bird_id_hit == self.images_hit.count) { bird_id_hit = 0 }
            birdi_on_top_hit(image_id: bird_id_hit)

        }
    }
}


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
