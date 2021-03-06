//
//  ViewController.swift
//  Rock the Boat
//
//  Created by Zheng, Minghui on 10/4/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var RockTheBoatLabel: UILabel!
    @IBOutlet weak var boatImg: UIImageView!
    @IBOutlet weak var fadeAnimBtn: UIButton!
    @IBOutlet weak var positionAnimBtn: UIButton!
    @IBOutlet weak var nestedAnimBtn: UIButton!
    @IBOutlet weak var constantAnimBtn: UIButton!
    @IBOutlet weak var stackview: UIStackView!
    var animationCount = 0
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var horizontalStackViewConstraint: NSLayoutConstraint!
    let boatModel = BoatModel()
    var needsRecover = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RockTheBoatLabel.text = NSLocalizedString("str_Rock", comment: "")
        fadeAnimBtn.setTitle(NSLocalizedString("str_fade", comment: ""), for: .normal)
        positionAnimBtn.setTitle(NSLocalizedString("str_positional", comment: ""), for: .normal)
        nestedAnimBtn.setTitle(NSLocalizedString("str_nested", comment: ""), for: .normal)
        constantAnimBtn.setTitle(NSLocalizedString("str_constrained", comment: ""), for: .normal)

    }

    @IBAction func onFade(_ sender: Any) {
        UIView.animate(withDuration: 2.4, animations: {
            self.boatImg?.alpha = 0.0
            self.boatImg?.alpha = 1.0
        })
    }
    @IBAction func onPositionalAnim(_ sender: Any) {
        if(needsRecover){
            UIView.animate(withDuration: 0.7, animations: {
                self.stackview?.rotate(by: 0, with: CGPoint(x: 0, y: 0))
            })
            needsRecover = boatModel.prositionalAnimRecover(needsRecover)
        }else if(!needsRecover){
            UIView.animate(withDuration: 0.7, animations: {
                self.stackview?.rotate(by: Double.pi / 4, with: CGPoint(x: -0.3, y: 0.3))
            })
            needsRecover = boatModel.prositionalAnimRecover(needsRecover)
        }
        
    }
    
    @IBAction func nestedAnim(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.boatImg?.rotate(by: 0.2, with: CGPoint(x: -0.3, y: 0.3))
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.boatImg?.rotate(by: 0.3, with: CGPoint(x: -0.2, y: 0.3))
                self.boatImg?.rotate(by: 0.0, with: CGPoint(x: 0.3, y: 0.1))
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.boatImg?.rotate(by: -0.5, with: CGPoint(x: -0.2, y: -0.1))
                }, completion: { _ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.boatImg?.rotate(by: 0.2, with: CGPoint(x: 0.3, y: -0.3))
                    })
                })
            })
        })
    }
    @IBAction func constraintAnim(_ sender: Any) {
        let delay = 0.1
        let yPos = self.view.frame.height

        UIView.animate(withDuration: 1.2, delay: delay, options: [.curveEaseInOut], animations: {
            self.labelTopConstraint?.constant += yPos
            self.horizontalStackViewConstraint?.constant += yPos

            self.view.layoutIfNeeded()
        }, completion: { _ in
            let yPos2 = -self.view.frame.height

            UIView.animate(withDuration: 1.2, delay: delay, options: [.curveEaseInOut], animations: {
                self.labelTopConstraint?.constant += yPos2
                self.horizontalStackViewConstraint?.constant += yPos2

                self.view.layoutIfNeeded()
            })
        
        })
    }
    
}

