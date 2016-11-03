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
    
    var newlyCreatedImageView:UIImageView! {
        didSet {
            newlyCreatedImageView.isUserInteractionEnabled = true
            let gestureRec = UIPanGestureRecognizer(target: self, action: #selector(onNewImageView(_:)))
            newlyCreatedImageView.addGestureRecognizer(gestureRec)
        }
    }
    
    var startPointOfImage: CGPoint!
    
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
        let imageView = sender.view as! UIImageView

        let translation = sender.translation(in: view)
        
//        let oldImageViewTranslate 
        if sender.state == .began{
            print("Gesture began at")

            let imageView = sender.view as! UIImageView
            startPointOfImage = imageView.center
            
            startPointOfImage = imageView.center
            newlyCreatedImageView = UIImageView(image: imageView.image)
            self.view.addSubview(newlyCreatedImageView)
            newlyCreatedImageView.center = imageView.center
            newlyCreatedImageView.center.y += trayView.frame.origin.y
            
        }else if sender.state == .changed{
            print("Gesture changed aT")

//            let imageView = sender.view as! UIImageView
            newlyCreatedImageView.center = CGPoint(x: startPointOfImage.x + translation.x, y: startPointOfImage.y + translation.y + trayView.frame.origin.y)
        
        }else if sender.state == .ended{
            
            

            
//            self.addPanTo(imageView: newlyCreatedImageView)
            
        }
    }
    
    
//    func addPanTo(imageView:UIImageView) {
//        let gestureRec = UIPanGestureRecognizer(target: self, action: #selector(onNewImageView(_:)))
//        imageView.addGestureRecognizer(gestureRec)
//        imageView.isUserInteractionEnabled = true
//        
//
//    }
    
    func onNewImageView(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began {
            print("ON NEW IMAGE VIEW")
 
        }
        
    }
}

