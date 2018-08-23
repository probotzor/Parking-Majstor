//
//  OdabirTabliceViewController.swift
//  Parking Majstor
//
//  Created by Milos Jakovljevic on 8/29/17.
//  Copyright © 2017 Milos Jakovljevic. All rights reserved.
//

import UIKit

class OdabirTabliceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.reloadData()
        table.layer.cornerRadius = 5.0
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
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var table: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.GlobalVariable.niztablica.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celija = table.dequeueReusableCell(withIdentifier: "mojaCelija", for: indexPath)
        celija.textLabel?.text = ViewController.GlobalVariable.niztablica[indexPath.row].cela
        if celija.textLabel?.text == ViewController.GlobalVariable.gradlabel + ViewController.GlobalVariable.brojlabel + ViewController.GlobalVariable.slovalabel {
            celija.isUserInteractionEnabled = false
            celija.backgroundColor = UIColor().HexToColor(hexString: "204d8f", alpha: 1.0)
            celija.textLabel?.textColor = UIColor.white
        }

        return celija
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celija = table.dequeueReusableCell(withIdentifier: "mojaCelija", for: indexPath)
        celija.textLabel?.text = ViewController.GlobalVariable.niztablica[indexPath.row].cela
        ViewController.GlobalVariable.gradlabel = ViewController.GlobalVariable.niztablica[indexPath.row].grad
        ViewController.GlobalVariable.brojlabel = ViewController.GlobalVariable.niztablica[indexPath.row].broj
        ViewController.GlobalVariable.slovalabel = ViewController.GlobalVariable.niztablica[indexPath.row].slova
        dismiss(animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
        ViewController.GlobalVariable.niztablica = ViewController.GlobalVariable.niztablica.filter { $0 != ViewController.GlobalVariable.niztablica[indexPath.row] }
        ArchiveUtil.saveTablica(tablica: ViewController.GlobalVariable.niztablica)
        table.reloadData()
        }
    }

    
    

    
}
