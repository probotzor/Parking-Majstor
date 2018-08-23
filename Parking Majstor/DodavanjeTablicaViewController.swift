//
//  DodavanjeTablicaViewController.swift
//  Parking Majstor
//
//  Created by Milos Jakovljevic on 8/29/17.
//  Copyright © 2017 Milos Jakovljevic. All rights reserved.
//

import UIKit

class DodavanjeTablicaViewController: UIViewController {

    override func viewDidLoad() {
        š.layer.cornerRadius = 5.0
        đ.layer.cornerRadius = 5.0
        č.layer.cornerRadius = 5.0
        ć.layer.cornerRadius = 5.0
        ž.layer.cornerRadius = 5.0
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var letters: UITextField!
    @IBOutlet weak var potvrdioutlet: UIButton!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    var grad: String! = ""
    var broj: String! = ""
    var slova: String! = ""
    var cela: String! = ""
    var deo: String! = ""
    
    @IBAction func potvrdi(_ sender: Any) {
        if city.text! == "" || number.text! == "" || letters.text! == "" {
            let alert = UIAlertController(title: "Greška!", message: "Morate popuniti sva polja!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else {
        grad = city.text!.uppercased()
        broj = number.text!.uppercased()
        slova = letters.text!.uppercased()
        deo = city.text!.uppercased() + number.text!.uppercased()
        cela =  deo + letters.text!.uppercased()
        
        let tablica = Tablica(grad: grad, broj: broj, slova: slova, cela: cela)
        ViewController.GlobalVariable.niztablica.append(tablica)
        print(ViewController.GlobalVariable.niztablica)
        ArchiveUtil.saveTablica(tablica: ViewController.GlobalVariable.niztablica)
            
            
            
        let alert = UIAlertController(title: "Uspeh!", message: "Uspešno ste dodali tablicu!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        self.present(alert, animated: true, completion: nil)

            
        }
    }
    
    @IBOutlet weak var š: UIButton!
    @IBOutlet weak var đ: UIButton!
    @IBOutlet weak var č: UIButton!
    @IBOutlet weak var ć: UIButton!
    @IBOutlet weak var ž: UIButton!
    
    @IBAction func dodajš(_ sender: Any) {
        letters.text?.append("Š")
    }
    
    @IBAction func dodajđ(_ sender: Any) {
        letters.text?.append("Đ")
    }
    @IBAction func dodajč(_ sender: Any) {
        letters.text?.append("Č")
    }
    @IBAction func dodajć(_ sender: Any) {
        letters.text?.append("Ć")
    }
    @IBAction func dodajž(_ sender: Any) {
        letters.text?.append("Ž")
    }
}
