//
//  ViewController.swift
//  consultaCEP
//
//  Created by Virtual Machine on 15/06/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputCEP: UITextField!
    @IBOutlet weak var inputRua: UITextField!
    @IBOutlet weak var inputBairro: UITextField!
    @IBOutlet weak var inputCidade: UITextField!
    @IBOutlet weak var inputEstado: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputCEP.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Service().get(cep: textField.text!) { result in
            DispatchQueue.main.async {
                switch result{
                case .failure(_):
                    break
                case .success(let cep):
                    self.inputRua.text = cep.logradouro
                    self.inputBairro.text = cep.bairro
                    self.inputCidade.text = cep.localidade
                    self.inputEstado.text = cep.uf
                    break
                }
            }
        }
    }
}

