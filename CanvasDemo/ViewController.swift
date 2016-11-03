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
    
    var newlyCreatedImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onTtayPanGesture(_ sender: UIPanGestureRecognizer) {
        
        
        let point = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        

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
                if velocity.y > 0.0 {
                    //going down
                    self.trayView.frame.origin.y = self.view.frame.size.height - 30
                }
                else {
                    //going up
                    
                    self.trayView.frame.origin.y = self.view.frame.size.height-self.trayView.frame.size.height
                }
                
                
            })
           
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onImageView(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began{
            
            let imageView = sender.view as! UIImageView
            
            newlyCreatedImageView = UIImageView(image: imageView.image)
            
            
            self.view.addSubview(newlyCreatedImageView)
            
            newlyCreatedImageView.center = imageView.center
            
        }else if sender.state == .changed{

        }else if sender.state == .ended{
        }
        
    }

}

