//
//  ViewController.swift
//  tokio 8
//
//  Created by Osasu sanchez on 25/3/26.
//

import UIKit

class ViewController: UIViewController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }


}



class Practica1: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    
    @IBOutlet weak var tfPass: UITextField!
    
    let userDefaults = UserDefaults.standard
    let keyUser = "userKey1"
    
    @IBOutlet weak var tvMostrar: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMostrar.text = "aqui se mostrara la informacion "
    }
    
    @IBAction func SaveData(_ sender: Any) {
        tvMostrar.text = ""
        
      saveUser(user: tfUsername.text!, pass: tfPass.text!)
    }
    @IBAction func ShowData(_ sender: Any) {
        
        tvMostrar.text = ""
        
        let userData = userDefaults.data(forKey: keyUser)
        if let userData = userData {
            do{
                let userDecoded = try JSONDecoder().decode(User.self, from: userData)
                tvMostrar.text = "👤 Usuario: \(userDecoded.user)\n🔑 Contraseña: \(userDecoded.pass)"
            }catch {
                print("error al decodificar")
            }
        }else {
            tvMostrar.text = "no hay datos guardados"
        }
        
    }
    
    func saveUser(user: String, pass: String){
        userDefaults.removeObject(forKey: keyUser)
        if !user.isEmpty && !pass.isEmpty{
            do{
                let userToSave = User(user: user, pass: pass)
                let data = try JSONEncoder().encode(userToSave)
                
                userDefaults.set(data, forKey: keyUser)
                tvMostrar.text = "Datos guardados correctamente"
                
            }catch {
                print("error al codificar")
            }
        }else {
            tvMostrar.text = "no se pudo guardar la informacion"
        }
        
    }
}


struct User : Codable{
    var user: String
    var pass: String
}
