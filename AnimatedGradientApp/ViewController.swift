//
//  ViewController.swift
//  AnimatedGradientApp
//  Created by DA MAC M1 157 on 2023/09/28.

import UIKit

class ViewController: UIViewController {
    
    let gradient = CAGradientLayer()
    
    var gradientSet = [[CGColor]]()
    
    var currentGradient = 0
    
    let gradientOne = UIColor(red: 48/255, green: 62/255, blue: 53/255, alpha: 1.0).cgColor
    
    let gradientTwo = UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1.0).cgColor
    
    let gradientThree = UIColor(red: 196/255, green: 70/255, blue: 107/255, alpha: 1.0).cgColor
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientOne])
        
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.drawsAsynchronously = true
        
        view.layer.addSublayer(gradient)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateGradient()
    }
    
    
    func animateGradient() {
        
        var previousGradient: Int!
        
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
            previousGradient = currentGradient - 1
        }
        
        else {
            currentGradient = 0
            previousGradient = gradientSet.count - 1
        }
        
        let gradientChangeAnim = CABasicAnimation(keyPath: "colors")
                                                
        gradientChangeAnim.duration = 5.0
        
        gradientChangeAnim.fromValue = gradientSet[previousGradient]
        gradientChangeAnim.toValue = gradientSet[currentGradient]
        
        gradient.setValue(currentGradient, forKey: "colorChange")
        gradientChangeAnim.delegate = self
        
        gradient.add(gradientChangeAnim, forKey: nil)
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if let colorChange = gradient.value(forKey: "colorChange") as? Int {
                gradient.colors = gradientSet[colorChange]
                animateGradient()
            }
        }
    }
}
