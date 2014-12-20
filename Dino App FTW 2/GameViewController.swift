//
//  GameViewController.swift
//  Dino App FTW 2
//
//  Created by JEexplanations on 12/6/14.
//  Copyright (c) 2014 JEexplanations. All rights reserved.
//

import UIKit
import SpriteKit




class GameViewController: UIViewController {
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    @IBAction func attack()
    {
        battle.attack(atkDinoNum:0)
    }
}