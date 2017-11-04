//
//  ResultsViewController.swift
//  LeaFinder
//
//  Created by Alisson L. Selistre on 04/11/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var spentTimeLabel: UILabel!
    @IBOutlet weak var numberOfNodesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        spentTimeLabel.text = String(format: "%.5f segundos", timeSpentInSearch)
        numberOfNodesLabel.text = "\(nodesTraveled)"
    }
}
