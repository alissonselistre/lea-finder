//
//  GenerateThreeViewController.swift
//  LeaFinder
//
//  Created by Alisson L. Selistre on 04/11/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

class GenerateTreeViewController: UIViewController {

    @IBOutlet weak var maxAmplitudeLabel: UILabel!
    @IBOutlet weak var maxAmplitudeSlider: UISlider!

    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var depthSlider: UISlider!

    @IBOutlet weak var generateTreeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateMaxAmplitudeValue(maxAmplitude)
        updateDepthValue(depth)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableInteraction(true)
    }

    //MARK: actions

    @IBAction func maxAmplitudeSliderChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        maxAmplitude = newValue
        updateMaxAmplitudeValue(newValue)
    }

    @IBAction func depthSliderChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        depth = newValue
        updateDepthValue(newValue)
    }

    @IBAction func generateTreeButtonPressed(_ sender: UIButton) {
        enableInteraction(false)
        activityIndicator.startAnimating()
        generateTree {
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "tree", sender: nil)
        }
    }

    // MARK: helpers

    private func enableInteraction(_ enable: Bool) {
        generateTreeButton.isEnabled = enable
        maxAmplitudeSlider.isEnabled = enable
        depthSlider.isEnabled = enable
    }

    private func updateMaxAmplitudeValue(_ value: Int) {
        maxAmplitudeSlider.value = Float(value)
        maxAmplitudeLabel.text = "Máxima Amplitude: \(value)"
    }

    private func updateDepthValue(_ value: Int) {
        depthSlider.value = Float(value)
        depthLabel.text = "Profundidade: \(value)"
    }
}

