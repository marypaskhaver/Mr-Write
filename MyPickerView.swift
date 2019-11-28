//
//  PickerView.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/28/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import UIKit

protocol MyPickerViewProtocol {
    func myPickerDidSelectRow(selectedRowValue: String)
}

class MyPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerList: [String] = []
    var pickerListItem: String!
    var propertyThatReferencesThisViewController: MyPickerViewProtocol?
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Tell ViewController item was selected
        propertyThatReferencesThisViewController?.myPickerDidSelectRow(selectedRowValue: pickerList[row])
        return pickerList[row]
    }

}
