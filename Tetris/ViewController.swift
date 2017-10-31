//
//  ViewController.swift
//  Tetris
//
//  Created by NEXTAcademy on 10/31/17.
//  Copyright © 2017 asd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var array1: [UIView] = []
    var array2: [UIView] = []
    var array3: [UIView] = []
    
    let color: [UIColor] = [UIColor.red, UIColor.green, UIColor.blue]
    
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var behaviour : UIDynamicItemBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        behaviour = UIDynamicItemBehavior()
        behaviour.allowsRotation = false
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(behaviour)
        animator.delegate = self
        addDropButton()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addDropButton() {
        let button = UIButton()
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 80))
        button.center = view.center
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Drop", for: .normal)
        button.addTarget(self, action: #selector(dropButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func dropButtonTapped() {
        let index = Int(arc4random_uniform(3))
        let colorIndex = Int(arc4random_uniform(3))
        var x : CGFloat!
        switch index {
        case 0:
            x = CGFloat(-1)
        case 1:
            x = CGFloat(60)
        case 2:
            x = CGFloat(120)
        default:
            x = 0
        }
        let block = UIButton(frame: CGRect(x: x, y: 0, width: 60, height: 60))
        block.backgroundColor = color[colorIndex]
        block.layer.cornerRadius = 30
        switch index {
        case 0:
            array1.append(block)
        case 1:
            array2.append(block)
        case 2:
            array3.append(block)
        default:
            return
        }
        view.addSubview(block)
        collision.addItem(block)
        gravity.addItem(block)
        behaviour.addItem(block)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        checkBlock()
    }
    
    func checkBlock() {
        if !array1.isEmpty && !array2.isEmpty && !array3.isEmpty {
            clearBlock()
        }
    }
    
    func clearBlock() {
        for array in [array1, array2, array3] {
            array[0].removeFromSuperview()
            gravity.removeItem(array[0])
            collision.removeItem(array[0])
            behaviour.removeItem(array[0])
        }
        dropFirstElement()
    }
    
    func dropFirstElement() {
        array1.removeFirst()
        array2.removeFirst()
        array3.removeFirst()
    }
}

