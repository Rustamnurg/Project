//
//  CreateObject.swift
//  Project
//
//  Created by Rustam N on 22.04.17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import MapKit


//TODO: сделать переименование активной кнопки

protocol Selectlement {
    func setElement(name: String, url: String, state: Int)
}


class CreateObject: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var transportSegment: UISegmentedControl!
    @IBOutlet weak var viewWithTextField: UIView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    var currentState = EventFlow.transport.state
    var currentPosition = EventFlow.transport.state
    var xBasicPosition = 0
    let cheingValue = -210
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xBasicPosition = Int(viewWithTextField.frame.origin.x)
        
        routeButton.setTitle(EventFlow.route.defaultName, for: .normal)
        directionButton.setTitle(EventFlow.direction.defaultName, for: .normal)
        directionButton.isEnabled = false
        stopButton.setTitle(EventFlow.stop.defaultName, for: .normal)
        stopButton.isEnabled = false
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        viewWithTextField.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        viewWithTextField.addGestureRecognizer(swipeRight)
        
    }
    
    func handSwipe(gestureRecognizer: UIGestureRecognizer) {
        if let swipeGesture = gestureRecognizer as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                guard currentPosition > 0 else {return}
                currentPosition -= 1
            case UISwipeGestureRecognizerDirection.left:
                guard currentPosition < currentState &&  currentPosition < 2 else { return}
                currentPosition += 1
            default:
                break
            }
            animationView(changePositionOnX: currentPosition  * cheingValue, changePageController: currentPosition)
            
        }
    }
    

    
    @IBAction func chengeTransport(_ sender: Any) {
        currentPosition = 0
        currentState = 1
        updataState(buttonLabel: EventFlow.route.defaultName, newState: EventFlow.transport.state + 1)
        
    }
    
    
    
    
    func animationView(changePositionOnX: Int, changePageController: Int){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewWithTextField.frame = CGRect(x: CGFloat(self.xBasicPosition + changePositionOnX), y: self.viewWithTextField.frame.origin.y, width: self.viewWithTextField.frame.width, height: self.viewWithTextField.frame.height)
            self.pageController.currentPage = changePageController
        }, completion: { (Bool) in
        })
    }
    
    func updataState(buttonLabel: String, newState: Int) {
        if newState < currentState || newState == 0 {
            switch newState {
            case EventFlow.transport.state:
                routeButton.setTitle(EventFlow.route.defaultName, for: .normal)
                directionButton.setTitle(EventFlow.direction.defaultName, for: .normal)
                directionButton.isEnabled = false
                stopButton.setTitle(EventFlow.stop.defaultName, for: .normal)
                stopButton.isEnabled = false
            case EventFlow.route.state:
                routeButton.setTitle("   \(buttonLabel)", for: .normal)
                routeButton.isEnabled = true
                directionButton.setTitle(EventFlow.direction.defaultName, for: .normal)
                directionButton.isEnabled = false
                stopButton.setTitle(EventFlow.stop.defaultName, for: .normal)
                stopButton.isEnabled = false
            case EventFlow.direction.state:
                directionButton.setTitle("   \(buttonLabel)", for: .normal)
                directionButton.isEnabled = true
                stopButton.setTitle(EventFlow.stop.defaultName, for: .normal)
                stopButton.isEnabled = false
            case EventFlow.stop.state:
                stopButton.setTitle("   \(buttonLabel)", for: .normal)
                stopButton.isEnabled = true
            default: break
            }
            animationView(changePositionOnX: (newState - 1) * cheingValue, changePageController: newState - 1)
        }
        else{
            switch newState {
            case EventFlow.route.state:
                routeButton.setTitle("   \(buttonLabel)", for: .normal)
                directionButton.isEnabled = true
            case EventFlow.direction.state:
                directionButton.setTitle("   \(buttonLabel)", for: .normal)
                stopButton.isEnabled = true
            case EventFlow.stop.state:
                stopButton.setTitle("   \(buttonLabel)", for: .normal)
            default: break
            }
            
            if newState < 3 {
                animationView(changePositionOnX: newState * cheingValue, changePageController: newState)
                currentPosition += 1
            }
        }
        currentState = newState
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        guard let identifier = segue.identifier else { return}
        var state = 0
        switch identifier{
        case String(EventFlow.route.state):
            state = EventFlow.route.state
        case String(EventFlow.direction.state):
            state = EventFlow.direction.state
        case String(EventFlow.stop.state):
            state = EventFlow.stop.state
        default:
            print("default!!")
        }
        
        if let nextViewController = segue.destination as? SearchController{
            nextViewController.state = state
            nextViewController.url = "URL"
            nextViewController.selectedElementDelegate = self
            
        }
    }
    
}

extension CreateObject: Selectlement {
    func setElement(name: String, url: String, state: Int) {
        if state == EventFlow.route.state {
            currentPosition = 0
            currentState = 1
            routeButton.isEnabled = true
        }
        updataState(buttonLabel: name, newState: state)
    }
}


