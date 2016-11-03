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
        let translation = sender.translation(in: view)

        if sender.state == .began{
            print("Gesture began at: \(point)")
            startPoint = trayView.center
            
            
        }else if sender.state == .changed{
            print("Gesture changed at: \(point)")
           trayView.center = CGPoint(x: startPoint.x, y: startPoint.y+translation.y)
        }else if sender.state == .ended{
            print("Gesture ended at: \(point)")
            
            UIView.animate(withDuration: 0.3, animations: {
                 self.trayView.center = CGPoint(x: self.startPoint.x, y: self.startPoint.y+translation.y)
                
            })
           
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

