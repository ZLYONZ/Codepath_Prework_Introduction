//
//  ViewController.swift
//  Introduce Prework
//
//  Created by LYON on 12/20/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var schoolLogo: UIImageView!
    
    @IBOutlet weak var fnameLabel: UILabel!
    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var petLabel: UILabel!
    @IBOutlet weak var numOfPetLabel: UILabel!
    @IBOutlet weak var morePetLabel: UILabel!
    
    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var lnameTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var morePetStepper: UIStepper!
    @IBOutlet weak var morePetSwitch: UISwitch!
    
    @IBOutlet weak var introduceBtn: UIButton!
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introduceBtn.layer.cornerRadius = 8
        introduceBtn.layer.masksToBounds = true
        
        self.petLabel.text = "Pet"
        self.numOfPetLabel.text = "0"
        
        self.fnameTextField.delegate = self
        self.lnameTextField.delegate = self
        self.schoolTextField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func stepperDidChanged(_ sender: UIStepper) {
        numOfPetLabel.text = "\(Int(sender.value))"
        petLabel.text = Int(sender.value) < 2 ? "Pet" : "Pets"
    }
    

    @IBAction func introduceTapped(_ sender: UIButton) {
        let year = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex)
        
        let suffix = Int(numOfPetLabel.text!)! < 2 ? "cat" : "cats"
        
        let introduction = "My name is \(fnameTextField.text!) \(lnameTextField.text!) and I attend \(schoolTextField.text!). I am currently in my \(year!) year and I own \(numOfPetLabel.text!) \(suffix). It is \(morePetSwitch.isOn) that I want more pets."
    
        storeData()
        
        let alertController = UIAlertController(title: "My Introduction", message: introduction, preferredStyle: .alert)
                                                
        let action = UIAlertAction(title: "Nice to meet you guys!", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fnameTextField:
            lnameTextField.becomeFirstResponder()
        case lnameTextField:
            schoolTextField.becomeFirstResponder()
        case schoolTextField:
            self.view.endEditing(true)
            return false
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let fname = defaults.object(forKey: "fnameText") as? String {
            fnameTextField.text = fname
        }
        loadData()
    }
    
    func storeData() {
        defaults.set(fnameTextField.text, forKey: "fnameText")
        defaults.set(lnameTextField.text, forKey: "lnameText")
        defaults.set(schoolTextField.text, forKey: "schoolText")
        defaults.set(numOfPetLabel.text, forKey: "numOfPet")
        defaults.set(petLabel.text, forKey: "petLabel")
    }
    
    func loadData() {
        fnameTextField.text = defaults.object(forKey: "fnameText") as? String
        lnameTextField.text = defaults.object(forKey: "lnameText") as? String
        schoolTextField.text = defaults.object(forKey: "schoolText") as? String
        numOfPetLabel.text = defaults.object(forKey: "numOfPet") as? String
        petLabel.text = defaults.object(forKey: "petLabel") as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Close Keyboard by touching anywhere
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
