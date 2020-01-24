//
//  PickerTestViewController.swift
//  SwiftEV3
//
//  Created by Pioneer-Robotics on 2019/6/25.
//  Copyright © 2019 Pioneer-Robotics. All rights reserved.
//

import UIKit
import ExternalAccessory

class PickerTestViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil)
        { (e) in
            
        }
    }
}
