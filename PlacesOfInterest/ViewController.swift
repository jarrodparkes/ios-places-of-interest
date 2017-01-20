//
//  ViewController.swift
//  PlacesOfInterest
//
//  Created by Jarrod Parkes on 1/20/17.
//  Copyright © 2017 Jarrod Parkes. All rights reserved.
//

import UIKit
import GooglePlaces

// MARK: - ViewControllerState

enum ViewControllerState {
    case initial
    case place
}

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var attributionsLabel: UILabel!
   
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        setupUI(state: .initial)
    }
    
    // MARK: Setup UI
    
    func setupUI(state: ViewControllerState, name: String = "", address: String = "", attributions: String = "") {
        switch state {
        case .initial:
            setLabels(hidden: true)
        case .place:
            setLabels(hidden: false, name: name, address: address, attributions: attributions)
        }
    }
    
    func setLabels(hidden: Bool, name: String = "", address: String = "", attributions: String = "") {
        setLabel(nameLabel, hidden: (name == "") ? true : hidden, text: name)
        setLabel(addressLabel, hidden: (address == "") ? true : hidden, text: address)
        setLabel(attributionsLabel, hidden: (attributions == "") ? true : hidden, text: attributions)
    }
    
    func setLabel(_ label: UILabel, hidden: Bool, text: String) {
        label.isHidden = hidden
        label.text = text
    }
    
    // MARK: Actions
    
    // Present the Autocomplete view controller when the button is pressed.
    @IBAction func onLaunchClicked(sender: UIButton) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
}

// MARK: - ViewController: GMSAutocompleteViewControllerDelegate

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        if let _ = place.attributions {
            setupUI(state: .place, name: place.name, address: place.formattedAddress ?? "", attributions: String(describing: place.attributions))
        } else {
            setupUI(state: .place, name: place.name, address: place.formattedAddress ?? "", attributions: "")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}

