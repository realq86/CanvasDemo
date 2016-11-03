//
//  ViewController.swift
//  CanvasDemo
//
//  Created by Developer on 11/2/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var startPoint : CGPoint!
    @IBOutlet weak var trayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onTtayPanGesture(_ sender: UIPanGestureRecognizer) {
        
        
        let point = sender.location(in: view)
        if sender.state == .began{
            print("Gesture began at: \(point)")
            startPoint = trayView.center
            
            
        }else if sender.state == .changed{
            print("Gesture changed at: \(point)")
            trayView.center = CGPoint(x: startPoint.x, y: startPoint.y+point.y)
        }else if sender.state == .ended{
            print("Gesture ended at: \(point)")
            trayView.center = CGPoint(x: startPoint.x, y: startPoint.y+point.y)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

