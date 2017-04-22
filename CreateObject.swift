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
    func setElement(name: String, url: String)
}


class CreateObject: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var transportSegment: UISegmentedControl!
    
    @IBOutlet weak var viewWithTextField: UIView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var routeButton: UIButton!
    
    @IBOutlet weak var directionButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        viewWithTextField.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        viewWithTextField.addGestureRecognizer(swipeRight)
        
    }
    
    func handSwipe(gestureRecognizer: UIGestureRecognizer) {
        if let swipeGesture = gestureRecognizer as? UISwipeGestureRecognizer {
            var change = 0
            var changePageController = 0
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                change = 200
                changePageController = -1
            case UISwipeGestureRecognizerDirection.left:
                change = -200
                changePageController = +1
            default:
                break
            }
            
            
            
            UIView.animate(withDuration: 0.5, animations: {
                gestureRecognizer.view?.frame = CGRect(x: CGFloat(Int((gestureRecognizer.view?.frame.origin.x)!) + change), y: (gestureRecognizer.view?.frame.origin.y)!, width: (gestureRecognizer.view?.frame.width)!, height: (gestureRecognizer.view?.frame.height)!)
                self.pageController.currentPage += changePageController
                
            }, completion: { (Bool) in
                
                
            })
            
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        guard let identifier = segue.identifier else { return}
        var stage = ""
        switch identifier{
        case SearchIdentifier.route.identifier:
            stage = SearchIdentifier.route.identifier
        case SearchIdentifier.direction.identifier:
            stage = SearchIdentifier.direction.identifier
        case SearchIdentifier.stop.identifier:
            stage = SearchIdentifier.stop.identifier
        default:
            print("default!!")
        }
        
        if let nextViewController = segue.destination as? SearchController{
            nextViewController.stage = stage
            nextViewController.url = "URL"
            nextViewController.selectedElementDelegate = self
            
        }
    }
    
}

extension CreateObject: Selectlement {
    func setElement(name: String, url: String) {
        routeButton.setTitle("   \(name)", for: .normal)
    }
}


