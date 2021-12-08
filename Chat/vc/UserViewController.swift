//
//  ViewController2.swift
//  chatApp
//
//  Created by loujain on 07/12/2021.
//

import UIKit
import Firebase

class UserViewController: UIViewController{
    let fireStoryURL = Firestore.firestore()
    var arrUser:[Users] = []
    var sendIDUser:String?
    var sendName:String?
    //textField
    var nameUser:String?
    
  
    @IBOutlet weak var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        getUsersFromfirestore()
    }
    
    func getUsersFromfirestore(){
        fireStoryURL.collection("Users").getDocuments { SnapShot , error in
            for user in SnapShot!.documents{
                print("=====")
                print(user.data())
                
                //1
                //                let name: String = user.get("Name") as! String
                //                let id: String = user.get("ID") as! String
                //                self.arrUser.append(Users(name: name, id: id))
                if Auth.auth().currentUser?.uid != user.get("ID")as!String{
                //2
                self.arrUser.append(Users(name:user.get("Name") as! String, id: user.get("ID") as! String))
            }
            }
            self.tabelView.reloadData()
        }
    }

    @IBAction func signOuut(_ sender: Any) {
        do{
            
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            
        }catch {
            print("error.\(error.localizedDescription)")
        }
    }
}

extension UserViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! UserTableViewCelll
        cell.userLabel.text = arrUser[indexPath.row].name
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "moveChat") as! ChatViewController
//        vc.userName = arrUsear[indexPath.row].name!
//        vc.userId = arrUsear[indexPath.row].id!
//        print("========" , arrUsear[indexPath.row].name! ," : ",arrUsear[indexPath.row].id!)
//                vc.modalPresentationStyle = .fullScreen
//                self.navigationController?.pushViewController(vc, animated: true)
        
        sendName = arrUser[indexPath.row].name
        sendIDUser = arrUser[indexPath.row].id
        performSegue(withIdentifier: "moveChat", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveChat"{
            let vc = ChatViewController()
            //        vc.idUser = sendName
            
            vc.idUser = sendIDUser
            vc.nameUserr = sendName
        }
    }
}
struct Users {
    var name:String?
    var id:String
}
