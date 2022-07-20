//
//  BottomExtension.swift
//  Task
//
//  Created by Mohannad Al Atrash on 17/07/2022.
//

//import UIKit

/**
 Category And Position View Controller Extension
 */
//extension CategoryAndPositionViewController {
//    
//    /**
//     Bottom view setup
//     */
//    func bottomViewSetup() {
//        self.bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        self.bottomView.layer.cornerRadius = 20
//        self.bottomView.isUserInteractionEnabled = true
//        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
//        self.initialViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 71)
//        self.expandedViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: self.expandedViewOffset)
//        self.expandedViewHeightConstraint.isActive = false
//        self.categoriesLabel.numberOfLines = 1
//        self.positionsLabel.numberOfLines = 1
//    }
//    
//    /**
//     Refresh selected view
//     */
//    func refreshSelectedView() {
//        
//        let categoryTopConstraint = self.categoriesLabel.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 0)
//        let categoryBottomConstraint = self.categoriesLabel.bottomAnchor.constraint(equalTo: self.positionsLabel.topAnchor, constant: 0)
//        let positionBottomConstraint = self.positionsLabel.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: 0)
//        let heightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 0)
//        
//        self.initialViewHeightConstraint.isActive = false
//        if !self.selectedCategories.isEmpty || !self.selectedPositions.isEmpty {
//            
//            self.initialViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 71)
//            self.initialViewHeightConstraint.isActive = true
//            
//            self.categoriesLabel.text = "Categories: "
//            self.positionsLabel.text = "Positions: "
//            
//            for category in selectedCategories {
//                self.categoriesLabel.text = self.categoriesLabel.text! + category + ", "
//            }
//            
//            for position in selectedPositions {
//                self.positionsLabel.text = self.positionsLabel.text! + position + ", "
//            }
//            
//            NSLayoutConstraint.deactivate([
//                categoryTopConstraint,
//                categoryBottomConstraint,
//                positionBottomConstraint,
//                heightConstraint
//            ])
//            
//        } else { // empty
//            self.initialViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 0)
//            self.initialViewHeightConstraint.isActive = true
//            NSLayoutConstraint.activate([
//                categoryTopConstraint,
//                categoryBottomConstraint,
//                positionBottomConstraint,
//                heightConstraint
//            ])
//        }
//    }
//    
//    /**
//     Gesture setup
//     */
//    func gestureSetup() {
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
//        self.bottomView.isUserInteractionEnabled = true
//        self.bottomView.addGestureRecognizer(panGestureRecognizer)
//    }
//    
//    /**
//     Did pan
//     */
//    @objc func didPan(_ sender: UIPanGestureRecognizer) {
//        let velocity = sender.velocity(in: view)
//        if sender.state == .ended {
//            if velocity.y < 0 {
//                self.initialViewHeightConstraint.isActive = false
//                self.expandedViewHeightConstraint.isActive = true
//                self.categoriesLabel.numberOfLines = 0
//                self.positionsLabel.numberOfLines = 0
//            } else {
//                self.initialViewHeightConstraint.isActive = true
//                self.expandedViewHeightConstraint.isActive = false
//                self.categoriesLabel.numberOfLines = 1
//                self.positionsLabel.numberOfLines = 1
//            }
//        }
//     }
//}
