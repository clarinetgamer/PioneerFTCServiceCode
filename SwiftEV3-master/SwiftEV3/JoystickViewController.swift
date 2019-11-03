//
//  ViewController.swift
//  SwiftEV3
//
//  Created by 謝飛飛 on 2019/6/13.
//  Copyright © 2019 謝飛飛. All rights reserved.
//

import UIKit
import CoreMotion

class JoystickViewController: UIViewController {
    let lmManager = LMEV3ConnectManager.shared
    let motionManager = CMMotionManager.init()
    
    let rightPort: OutputPort = .C
    let leftPort: OutputPort = .B
    let defaultPorts: OutputPort = [.B, .C] //WHY?
    
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var codeTextView: UITextView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(eV3ConnectSuccess), name: LMEV3ConnectSuccess, object: nil)
        lmManager.findEV3Accessory()
        themeUI()
    }
    
    @IBAction func btnBLE(_ sender: Any) {
        lmManager.eaManager.showBluetoothAccessoryPicker(withNameFilter: nil) { (e) in
        
        }
    }
    
    @objc func eV3ConnectSuccess() {
        
    }
                
    @IBAction func leftButtonPressed(_ sender: Any) {
        simpleTurn(isLeft: true)

//        let slowSpeed = Int16(25)
//        let fastSpeed = Int16(75)
//
//        let command = Ev3Command(commandType: .directNoReply)
//        command.turnMotorAtPower(ports: rightPort,
//                                 power: fastSpeed)
//        command.turnMotorAtPower(ports: leftPort,
//                                 power: slowSpeed)
//        command.startMotor(ports: defaultPorts)
//        lmManager.brick?.sendCommand(command)
    }

    @IBAction func rightButtonPressed(_ sender: Any) {
        simpleTurn(isLeft: false)
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        moveRotations(forward: true)
    }

    @IBAction func downButtonPressed(_ sender: Any) {
        moveRotations(forward: false)
    }

    
    @IBAction func stopButtonPressed(_ sender: Any) {
//        lmManager.brick?.directCommand.stopMotor(onPorts: defaultPorts, withBrake: true)
    }
    
    // MARK: - Private Methods
    private func simpleTurn(isLeft: Bool) {
        let command = Ev3Command(commandType: .directNoReply)
        let step: UInt32 = 175
        command.stepMotorSync(ports: defaultPorts,
                              speed: 25,
                              turnRatio: (isLeft) ? -200 : 200,
                              step: step,
                              brake: true)
        
        command.startMotor(ports: defaultPorts)
        lmManager.brick?.sendCommand(command)
    }
    
    private func moveRotations(_ rotations: Double = 1, forward: Bool) {
        let command = Ev3Command(commandType: .directNoReply)
        let step: UInt32 = UInt32(365 * rotations)
        command.stepMotorSync(ports: defaultPorts,
                              speed: forward ? 25 : -25,
                              turnRatio: 0,
                              step: step,
                              brake: true)
        
        command.startMotor(ports: defaultPorts)
        lmManager.brick?.sendCommand(command)
    }
    
    private func themeUI() {
        for button in buttons {
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 8
        }
        codeTextView.layer.borderColor = UIColor.black.cgColor
        codeTextView.layer.borderWidth = 4
    }
}
