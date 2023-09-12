//
//  EmailLoginViewController.swift
//  CS4261FirstProgrammingAssignment
//
//  Created by Rohan Bodla on 9/11/23.
//

import UIKit
import Firebase

class EmailLoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        guard let email = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseCompletion, error in
            if let e = error {
                print("error: " + error.debugDescription)
            } else {
                //go to next
                self.performSegue(withIdentifier: "successfulLogIn", sender: self)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
