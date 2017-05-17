//
//  ViewController.swift
//  CanvasDemo
//
//  Created by Developer on 11/2/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    var startPoint : CGPoint!
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var arrayImageView: UIImageView!
    
    var newlyCreatedImageView:UIImageView! {
        didSet {
            newlyCreatedImageView.isUserInteractionEnabled = true
            let panGestureRec = UIPanGestureRecognizer(target: self, action: #selector(panNewImageView(_:)))
            panGestureRec.delegate = self
            newlyCreatedImageView.addGestureRecognizer(panGestureRec)
            
            let pinchGestureRec = UIPinchGestureRecognizer(target: self, action: #selector(pinchImageView(_:)))
            pinchGestureRec.delegate = self
            
            newlyCreatedImageView.addGestureRecognizer(pinchGestureRec)
        }
    }
    
    var startPointOfImage: CGPoint!
    
    var sizeOfImage:CGSize!
    
    var trayIsOpen:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onTtayPanGesture(_ sender: UIPanGestureRecognizer) {
        
        print("Tray Pan")
        let point = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began{
            
            print("Tray Gesture began at: \(point)")
            startPoint = trayView.center


        }else if sender.state == .changed{
            
            print("Tray Gesture changed at: \(point)")
            trayView.center = CGPoint(x: startPoint.x, y: startPoint.y+translation.y)
            
            let angleDegree = Float(translation.y).truncatingRemainder(dividingBy: 180)
            
            self.arrayImageView.transform = CGAffineTransform(rotationAngle: (CGFloat(angleDegree * .pi/180)))
            
        }else if sender.state == .ended{
            
            print("Tray Gesture ended at: \(point)")
            

            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.1,
                           options: [],
                           animations: {
                            self.trayView.center = CGPoint(x: self.startPoint.x, y: self.startPoint.y+translation.y)
                            if velocity.y > 0.0 {
                                //going down
                                self.trayView.frame.origin.y = self.view.frame.size.height - 30
                                self.trayIsOpen = false
                            }
                            else {
                                //going up
                                self.trayView.frame.origin.y = self.view.frame.size.height-self.trayView.frame.size.height
                                self.trayIsOpen = true
                            }
            },
                           completion: { (complete:Bool) in
                            
            })
        }
        else if sender.state == .failed {
            
            print("Tray Gesture failed")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onImageView(_ sender: UIPanGestureRecognizer) {
        print("View Pan")

        let translation = sender.translation(in: view)
        
        if sender.state == .began{
            print("View Gesture began at")

            let imageView = sender.view as! UIImageView
            startPointOfImage = imageView.center
            
            newlyCreatedImageView = UIImageView(image: imageView.image)
            self.view.addSubview(newlyCreatedImageView)
            newlyCreatedImageView.center = imageView.center
            newlyCreatedImageView.center.y += trayView.frame.origin.y
        }else if sender.state == .changed{
            print("View Gesture changed aT")

            newlyCreatedImageView.center = CGPoint(x: startPointOfImage.x + translation.x, y: startPointOfImage.y + translation.y + trayView.frame.origin.y)
        }else if sender.state == .ended{

        }
    }
    
    
//    func addPanTo(_ imageView:UIImageView) {
//        
//        let gestureRec = UIPanGestureRecognizer(target: self, action: #selector(panNewImageView(_:)))
//        imageView.addGestureRecognizer(gestureRec)
//        imageView.isUserInteractionEnabled = true
//    }
//    
//    func addPinchTo(_ imageView:UIImageView) {
//        
//        let gesturRec = UIPinchGestureRecognizer(target: self, action: #selector(pinchImageView(_:)))
//        
//        imageView.addGestureRecognizer(gesturRec)
//        imageView.isUserInteractionEnabled = true
//    }
    
    func pinchImageView (_ sender:UIPinchGestureRecognizer) {
    
        let view = sender.view
//        let originalScale = 
        switch sender.state {
        case .began:
            print("Begin pinch")
            
            break
        case .changed:
            
            view?.transform = (view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1
            print("Pinch changed")
            break
        default:
            break
        }
    }
    
    func panNewImageView(_ sender: UIPanGestureRecognizer) {
        
        let view = sender.view!
        
        switch sender.state {
        case .began:
            self.sizeOfImage = sender.view?.bounds.size

            UIView.animate(withDuration: 0.2, animations: {
                view.transform = view.transform.scaledBy(x: 2, y: 2)
            })
        case .changed:
            var delta = sender.translation(in: self.view)
            delta.x += view.center.x
            delta.y += view.center.y
            
            view.center = delta
            
            sender.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            UIView.animate(withDuration: 0.2, animations: {
                view.transform = view.transform.scaledBy(x: 0.5, y: 0.5)

            })
        default: break
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

