//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Jakub Kozlowicz on 05.06.19.
//  Copyright © 2019 Jakub Kozlowicz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,
    UITextFieldDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextFieldWithBorder!
    @IBOutlet var serialNumberField: UITextFieldWithBorder!
    @IBOutlet var valueField: UITextFieldWithBorder!
    @IBOutlet var dateLabel: UITextFieldWithBorder!
    @IBOutlet var imageView: UIImageView!
    
    var imageStore: ImageStore!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    @IBAction func clearImage(_ sender: UIButton) {
        imageView.image = nil
        if imageStore.image(forkey: item.itemKey) != nil {
            imageStore.deleteImage(forkey: item.itemKey)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        imageStore.setImage(image!, forKey: item.itemKey)
        
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePicutre(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDatePicker"?:
            
            let dateCreatedDetailViewController = segue.destination as! ItemDateCreatedDetailViewController
            dateCreatedDetailViewController.item = item
            
        default: preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueInDollars = valueField.text,
            let value = numberFormatter.number(from: valueInDollars) {
                item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        
        if let valueInDollars = item.valueInDollars {
            valueField.text = numberFormatter.string(from: NSNumber(value: valueInDollars))
        } else {
            valueField.text = ""
        }
        
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        imageView.image = imageStore.image(forkey: item.itemKey)
        
    }
    
}
