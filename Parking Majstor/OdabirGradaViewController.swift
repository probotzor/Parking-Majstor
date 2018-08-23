//
//  OdabirGradaViewController.swift
//  Parking Majstor
//
//  Created by Milos Jakovljevic on 8/29/17.
//  Copyright © 2017 Milos Jakovljevic. All rights reserved.
//

import UIKit

class OdabirGradaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        for gr in ViewController.GlobalVariable.lokacije {
            print(gr.grad)
        }
        table.dataSource = self
        table.delegate = self
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
    @IBOutlet weak var table: UITableView!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.GlobalVariable.filterlokacije.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celija = table.dequeueReusableCell(withIdentifier: "gradCelija", for: indexPath)
        celija.textLabel?.text = ViewController.GlobalVariable.filterlokacije[indexPath.row].grad
        if celija.textLabel?.text == ViewController.GlobalVariable.imegrada {
            celija.isUserInteractionEnabled = false
            celija.backgroundColor = UIColor().HexToColor(hexString: "204d8f", alpha: 1.0)
            celija.textLabel?.textColor = UIColor.white
        }
        return celija
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celija = table.dequeueReusableCell(withIdentifier: "gradCelija", for: indexPath)
        celija.textLabel?.text = ViewController.GlobalVariable.filterlokacije[indexPath.row].grad
        ViewController.GlobalVariable.imegrada = ViewController.GlobalVariable.filterlokacije[indexPath.row].grad
        dismiss(animated: true, completion: nil)
        
    }


}
