//
//  ViewController.swift
//  SwiftEV3
//
//  Created by CFHS-FTC on 2019/6/13.
//  Copyright © 2019 CFHS-FTC. All rights reserved.
//

import UIKit
import CoreMotion

class JoystickViewController: UIViewController {
    let lmManager = LMEV3ConnectManager.shared
    let motionManager = CMMotionManager.init()
    
    let rightPort: OutputPort = .C
    let leftPort: OutputPort = .B
    let defaultPorts: OutputPort = [.B, .C] //WHY?
    
    
    var commands: [Command] = []   {
        didSet{
            debugPrint("commands: \(commands.map { $0.directionText })")
        }
    }
    
    
    
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var codeBackgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var directionsLabel: UILabel!

    
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
//        let _ = simpleTurn(isLeft: true)
        let command = MoveLeftCommand(runFunction: simpleTurnLeft)
        commands.append(command)
        tableView.reloadData()

    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
//        let _ = simpleTurn(isLeft: false)
        let command = MoveRightCommand(runFunction: simpleTurnRight)
        commands.append(command)
        tableView.reloadData()
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
//        let _ = moveRotations(forward: true)
        let command = MoveForwardCommand(runFunction: simpleForwardMove)
        commands.append(command)
        tableView.reloadData()

    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
//        let _ = moveRotations(forward: false)
        let command = MoveBackwardCommand(runFunction: simpleBackwardMove)
        commands.append(command)
        tableView.reloadData()

    }
    
    
    @IBAction func stopButtonPressed(_ sender: Any) {
//        lmManager.brick?.directCommand.stopMotor(onPorts: defaultPorts, withBrake: true)
    }
    
    @IBAction func instructionsButtonsPressed(_ sender: UIButton) {
        if let text = directionsLabel.text {
        SpeakTextManager.shared.speak(text)
        }
    }
    
    @IBAction func goButtonsPressed(_ sender: UIButton) {
        runQueue()
    }

    // MARK: - Private Methods
    @objc private func simpleTurnLeft() {
        let _ = simpleTurn(isLeft: true)
    }
    @objc private func simpleTurnRight(){
        let _ = simpleTurn(isLeft: false)
    }
    @objc private func simpleForwardMove(){
        let _ = moveRotations(1, forward: true)
    }
    @objc private func simpleBackwardMove(){
        let _ = moveRotations(1, forward: false)
    }

    private func simpleTurn(isLeft: Bool, shouldSend: Bool = true) -> Ev3Command {
        let command = Ev3Command(commandType: .directNoReply)
        let step: UInt32 = 175
        command.stepMotorSync(ports: defaultPorts,
                              speed: 25,
                              turnRatio: (isLeft) ? -200 : 200,
                              step: step,
                              brake: true)
        if (shouldSend) {
            command.startMotor(ports: defaultPorts)
            lmManager.brick?.sendCommand(command)
        }
        return command
    }
    
    private func moveRotations(_ rotations: Double = 1, forward: Bool, shouldSend: Bool = true) -> Ev3Command {
        let command = Ev3Command(commandType: .directNoReply)
        let step: UInt32 = UInt32(365 * rotations)
        command.stepMotorSync(ports: defaultPorts,
                              speed: forward ? 25 : -25,
                              turnRatio: 0,
                              step: step,
                              brake: true)
        if (shouldSend){
        command.startMotor(ports: defaultPorts)
        lmManager.brick?.sendCommand(command)
    }
        return command
    }
    
    private func themeUI() {
        for button in buttons {
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 8
        }
        codeBackgroundView.layer.borderColor = UIColor.black.cgColor
        codeBackgroundView.layer.borderWidth = 4
    }
    
    private func runQueue() {
        for (idx, command) in commands.enumerated() {
            let secondsSpacing: TimeInterval = 4
            let delay =  (secondsSpacing * TimeInterval(idx))
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                command.runFunction()
            }
        }
    }
}

extension JoystickViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = commands[indexPath.row].directionText
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            commands.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
