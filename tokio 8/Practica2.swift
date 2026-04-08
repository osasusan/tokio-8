//
//  Practtica2.swift
//  tokio 8
//
//  Created by Osasu sanchez on 8/4/26.
//

import Foundation
import UIKit

class Practica2: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tvMostrar: UITextView!
    
    let userDefaults = UserDefaults.standard
    let keyUser2 = "userKey2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Asignamos el delegate a los dos campos
        tfUsername.delegate = self
        tfPass.delegate = self
        
        tvMostrar.text = "Aquí se mostrará la información"
    }
    @IBAction func mostrarDatos(_ sender: Any) {
        let userData = userDefaults.data(forKey: keyUser2)
        
        if let userData = userData {
            do {
                let userDecoded = try JSONDecoder().decode(User.self, from: userData)
                tvMostrar.text = "👤 Usuario: \(userDecoded.user)\n🔑 Contraseña: \(userDecoded.pass)"
            } catch {
                tvMostrar.text = "Error al leer los datos"
                print("Error al decodificar: \(error)")
            }
        } else {
            tvMostrar.text = "No hay datos guardados"
        }
    }
}

    // MARK: - UITextFieldDelegate
extension Practica2: UITextFieldDelegate {
    
        //ocultarr con return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
       //guardarr auto
    func textFieldDidEndEditing(_ textField: UITextField) {
        guardarSiHayDatos()
    }
}

    // MARK: - Lógica de guardado
extension Practica2 {
    
    func guardarSiHayDatos() {
        guard let user = tfUsername.text, !user.isEmpty,
              let pass = tfPass.text, !pass.isEmpty else {
            tvMostrar.text = "Rellena usuario y contraseña"
            return
        }
        saveUser(user: user, pass: pass)
    }
    
    func saveUser(user: String, pass: String) {
        userDefaults.removeObject(forKey: keyUser2)
        do {
            let userToSave = User(user: user, pass: pass)
            let data = try JSONEncoder().encode(userToSave)
            userDefaults.set(data, forKey: keyUser2)
            tvMostrar.text = "Datos guardados automáticamente"
        } catch {
            tvMostrar.text = "Error al guardar"
            print("Error al codificar: \(error)")
        }
    }
}


