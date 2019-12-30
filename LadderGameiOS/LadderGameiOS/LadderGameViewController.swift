//
//  LadderGameViewController.swift
//  LadderGameiOS
//
//  Created by mine on 2019/11/14.
//  Copyright © 2019 sweetpt365. All rights reserved.
//

import UIKit
import LadderGameLibrary

class LadderGameViewController: UIViewController {
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var namesTextField: UITextField!
    @IBOutlet weak var ladderView: UIView!
    
    var presenter: LadderGamePresenterProtocol!
    
    func set(_ presenter: LadderGamePresenterProtocol) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        ladderView.layer.borderColor = UIColor.green.cgColor
        ladderView.layer.borderWidth = 2.0
    }

    @IBAction func ladderButtonPressed(_ sender: Any) {
        presenter.buildLadderMatrix(height: heightTextField.text ?? "", names: namesTextField.text ?? "")
    }
    
}

extension LadderGameViewController: LadderGameView {
    
    func displayLadderMatrix(_ ladder: LadderMatrix?) {
        if let ladder = ladder {
            let path = DisplayedLadderMatrix.build(from: ladder)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.black.cgColor
            ladderView.layer.addSublayer(shapeLayer)
        }
    }
}
