//
//  ViewController.swift
//  Parking Majstor
//
//  Created by Milos Jakovljevic on 8/29/17.
//  Copyright © 2017 Milos Jakovljevic. All rights reserved.
//

import UIKit
import MessageUI


extension Array
{
    func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element]
    {
        var uniqueKeys = Set<String>()
        return filter{uniqueKeys.insert("\(keyValue($0))").inserted}
    }
}



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMessageComposeViewControllerDelegate {

    
    struct GlobalVariable{
        static var niztablica = [Tablica]()
        static var lokacije = [Lokacije]()
        static var filterlokacije = [Lokacije]()
        static var imegrada = "Beograd"
        static var gradlabel = ""
        static var brojlabel = ""
        static var slovalabel = ""
    }

    var lokacije = [Lokacije]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(lokacije)
        collection.delegate = self
        collection.dataSource = self
        odabirgradaoutlet.layer.cornerRadius = 5.0
        parseCSV()
        gradoutlet.text = GlobalVariable.gradlabel
        brojoutlet.text = GlobalVariable.brojlabel
        slovaoutlet.text = GlobalVariable.slovalabel
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ArchiveUtil.loadTablica() != nil {
        GlobalVariable.niztablica = ArchiveUtil.loadTablica()!
        } else {
        GlobalVariable.niztablica.removeAll()
        }
        gradoutlet.text = GlobalVariable.gradlabel
        brojoutlet.text = GlobalVariable.brojlabel
        slovaoutlet.text = GlobalVariable.slovalabel
       // if imegradaoutlet.text! != GlobalVariable.imegrada {
        parseCSV()
      //  }
        lokacije = lokacije.filter { $0.grad == "\(GlobalVariable.imegrada)" }
        imegradaoutlet.text! = GlobalVariable.imegrada
        //collection.reloadData()
        //ViewController.GlobalVariable.filterlokacije = ViewController.GlobalVariable.lokacije

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var imegradaoutlet: UILabel!
    @IBOutlet weak var izaberioutlet: UIButton!
    @IBOutlet weak var odabirgradaoutlet: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var gradoutlet: UILabel!
    @IBOutlet weak var brojoutlet: UILabel!
    @IBOutlet weak var slovaoutlet: UILabel!
    
    func parseCSV() {
        lokacije.removeAll()
        let path = Bundle.main.path(forResource: "parking", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let grad = row["grad"]!
                let zona = row["zona"]!
                let opis = row["opis"]!
                let broj = row["broj"]!
                let boja = row["boja"]!
                
                let parking = Lokacije(grad: grad, zona: zona, opis: opis, broj: broj, boja: boja)
                lokacije.append(parking)
                GlobalVariable.filterlokacije = lokacije.filterDuplicate{ ($0.grad) }
                GlobalVariable.filterlokacije.sort { $0.grad < $1.grad }
                //GlobalVariable.lokacije = lokacije
                
                
            }
            collection.reloadData()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParkingCell", for: indexPath) as? ParkingCell {
            
            let parking: Lokacije!
            parking = lokacije[indexPath.row]
            cell.configureCell(lokacije: parking)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let parking: Lokacije!
        parking = lokacije[indexPath.row]
        let sadrzaj = gradoutlet.text! + brojoutlet.text! + slovaoutlet.text!
        let messageVC = MFMessageComposeViewController()
        messageVC.body = sadrzaj
        messageVC.recipients = ["\(parking.broj!)"]
        messageVC.messageComposeDelegate = self
        
        present(messageVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return lokacije.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 288, height: 61)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.failed.rawValue :
            print("message canceled")
            let alert = UIAlertController(title: "Obaveštenje!", message: "Poruka je otkazana!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        case MessageComposeResult.failed.rawValue :
            print("message failed")
            let alert = UIAlertController(title: "Obaveštenje!", message: "Poruka je otkazana!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        case MessageComposeResult.sent.rawValue :
            print("message sent")
            let alert = UIAlertController(title: "Uspeh!", message: "Poruka je poslata!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }



}

