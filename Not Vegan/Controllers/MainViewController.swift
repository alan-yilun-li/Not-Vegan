//
//  ViewController.swift
//  Not Vegan
//
//  Created by Alan Li on 2018-01-22.
//  Copyright © 2018 Alan Li. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    var searchText: String {
        get {
            return searchField.text ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        
        SearchManager.shared.search(for: searchText)
    }
    
}

extension MainViewController: UITextFieldDelegate {
    

    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterCountLimit = 100
        
        // Figuring out how many characters the unaltered string would have
        let startingLength = textFieldToChange.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace = range.length
        
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        return newLength <= characterCountLimit
    }
}
