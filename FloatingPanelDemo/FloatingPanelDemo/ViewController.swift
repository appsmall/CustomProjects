//
//  ViewController.swift
//  FloatingPanelDemo
//
//  Created by Rahul Chopra on 31/05/19.
//  Copyright © 2019 Rahul Chopra. All rights reserved.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController {
    
    var searchPanelVC: FloatingPanelController!
    var detailPanelVC: FloatingPanelController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Search panel
        self.searchPanelVC = FloatingPanelController()
        
        let searchVC = SearchViewController()
        self.searchPanelVC.show(searchVC, sender: nil)
        //self.searchPanelVC.track(scrollView: contentVC.tableView)
        
        self.searchPanelVC.add(toParent: self)
        
        // Setup Detail panel
        self.detailPanelVC = FloatingPanelController()
        
        let contentVC = ContentViewController()
        self.detailPanelVC.show(contentVC, sender: nil)
        //self.detailPanelVC.track(scrollView: contentVC.scrollView)
        
        self.detailPanelVC.add(toParent: self)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchPanelVC.removeFromParent()
        detailPanelVC.removeFromParent()
    }
    
}

extension ViewController : FloatingPanelControllerDelegate {
    // Make your contents correspond with FloatingPanel behavior
    
    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.position == .full {
            
        }
    }
    
    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
        if targetPosition == .full {
            print("Full")
        }
        else if targetPosition == .half {
            print("Half")
        }
        else if targetPosition == .tip {
            print("Tip")
        }
    }
    
    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
        return FloatingPanelStockBehavior()
    }
    
}


class FloatingPanelStockBehavior : FloatingPanelBehavior {
    // Animation on View Size Full, Half and Tip
    func interactionAnimator(to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator {
        
        let springTiming = UISpringTimingParameters(dampingRatio: 0.5, initialVelocity: velocity)
        return UIViewPropertyAnimator(duration: 1.0, timingParameters: springTiming)
    }
    
    
    var velocityThreshold: CGFloat {
        return 15.0
    }
    
}
