//
//  Practica 3.swift
//  tokio 8
//
//  Created by Osasu sanchez on 8/4/26.
//

import Foundation

import UIKit

class Practica3: UIViewController {
    
    @IBOutlet weak var tvMostrar: UITextView!
    
    let fileManager = FileManager.default
    let userDefaults = UserDefaults.standard
    
    let keyPractica1 = "userKey1"
    let keyPractica2 = "userKey2"
    
    var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("usuarios.xml")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvMostrar.text = "Aquí se mostrará la información"
    }
    
    @IBAction func guardarDatos(_ sender: Any) {
        var userP1 = "sin datos"
        var passP1 = "sin datos"
        var userP2 = "sin datos"
        var passP2 = "sin datos"
        
            // Recuperar datos Práctica 1
        if let userData = userDefaults.data(forKey: keyPractica1),
           let decoded = try? JSONDecoder().decode(User.self, from: userData) {
            userP1 = decoded.user
            passP1 = decoded.pass
        }
        
            // Recuperar datos Práctica 2
        if let userData = userDefaults.data(forKey: keyPractica2),
           let decoded = try? JSONDecoder().decode(User.self, from: userData) {
            userP2 = decoded.user
            passP2 = decoded.pass
        }
        
            // Construimos el XML con los datos de ambas prácticas
        let xmlContent = """
        <?xml version="1.0" encoding="UTF-8"?>
        <datos>
            <practica1>
                <user>\(userP1)</user>
                <pass>\(passP1)</pass>
            </practica1>
            <practica2>
                <user>\(userP2)</user>
                <pass>\(passP2)</pass>
            </practica2>
        </datos>
        """
        
        let data = xmlContent.data(using: .utf8)
        let directorioDocuments = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        if fileManager.createFile(atPath: "\(directorioDocuments)/usuarios.xml", contents: data) {
            print("archivo guardado en \(directorioDocuments)")
            tvMostrar.text = """
            ✅ XML creado con:
            
            📁 Práctica 1:
            👤 \(userP1)
            🔑 \(passP1)
            
            📁 Práctica 2:
            👤 \(userP2)
            🔑 \(passP2)
            """
        } else {
            tvMostrar.text = "Error al crear el XML"
        }
    }
    
    @IBAction func mostrarDatos(_ sender: Any) {
        guard fileManager.fileExists(atPath: fileURL.path) else {
            tvMostrar.text = "No hay fichero guardado todavía"
            return
        }
        
        do {
            let xmlContent = try String(contentsOf: fileURL, encoding: .utf8)
            tvMostrar.text = xmlContent
        } catch {
            tvMostrar.text = "Error al leer el fichero"
        }
    }
}

 
