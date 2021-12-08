//
//  ViewController.swift
//  Chat
//
//  Created by loujain on 07/12/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
let fireStoryURL = Firestore.firestore()
var arrUser:[User] = []

    @IBOutlet weak var nameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInAction(_ sender: Any) {
// sign in anonymously only if the use isn't registered ,if registered, directly go to UserViewController
        if Auth.auth().currentUser?.uid == nil {
            Auth.auth().signInAnonymously { user, error in
                if error == nil{
                    let dataUser = ["Name": self.nameText.text,"ID":user?.user.uid]
                    self.fireStoryURL.collection("Users").document((user?.user.uid)!).setData(dataUser)
                    self.performSegue(withIdentifier: "moveHome", sender: self)
                }
            }
        }
        else{
            self.performSegue(withIdentifier: "moveHome", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "singned"{
            let vc = UserViewController()
            vc.nameUser = nameText.text
        }
    }
}



