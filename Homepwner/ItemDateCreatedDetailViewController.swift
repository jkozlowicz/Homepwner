//
//  ItemDateCreatedDetailView.swift
//  Homepwner
//
//  Created by Jakub Kozlowicz on 09.06.19.
//  Copyright © 2019 Jakub Kozlowicz. All rights reserved.
//

import UIKit

class ItemDateCreatedDetailViewController: UIViewController {
    
    var item: Item!
    
    @IBOutlet var dateCreatedPicker: UIDatePicker!
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = self.dateCreatedPicker.date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dateCreatedPicker.date = item.dateCreated
    }
    
}
