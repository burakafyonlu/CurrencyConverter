//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Burak Afyonlu on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRates(_ sender: Any) {
        
       // 1)Request & Session
       // 2)Response & Data
       // 3)Parsing & JSON Serialization
        
        //1
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                //2
                
                if data != nil {
                    do {
                    
                        let JSONResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                        
                            if let rates = JSONResponse["rates"] as? [String : Any] {
                            
                            if let cad = rates["CAD"] as? Double {
                                self.cadLabel.text = "CAD: \(cad)"
                            }
                            if let chf = rates["CHF"] as? Double {
                                self.chfLabel.text = "CHF: \(chf)"
                            }
                            if let gbp = rates["GBP"] as? Double {
                                self.gbpLabel.text = "GBP: \(gbp)"
                            }
                            if let jpy = rates["JPY"] as? Double {
                                self.jpyLabel.text = "JPY: \(jpy)"
                            }
                            if let usd = rates["USD"] as? Double {
                                self.usdLabel.text = "USD: \(usd)"
                            }
                            if let türkish = rates["TRY"] as? Double {
                                self.tryLabel.text = "TRY: \(türkish)"
                            }
                        }
                    }
                } catch {
                    print("Error")
                    
                }}
            }
        }
        task.resume()
        
    }
}

