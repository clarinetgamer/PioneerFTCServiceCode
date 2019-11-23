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
    
    let armPort: OutputPort = .A
    let rightPort: OutputPort = .C
    let leftPort: OutputPort = .B
    let defaultPorts: OutputPort = [.B, .C] //WHY?
    let armPorts: OutputPort = [.A]
    
    
    var commands: [Command] = []   {
        didSet{
            debugPrint("commands: \(commands.map { $0.directionText })")
        }
    }
    var currentTaskIdx = 0
    var tasks: [Task] = [
        Task(lessonNum: 1,
            directionsText: "Geronimo the robot is stuck out on a bridge! Add the Move Forward Command 3 times to drive your robot out and save him.",
             simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self]),
        Task(lessonNum: 2,
        directionsText: "1Bot",
         simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self])
        //This is where complex answer goes on later lessons
    ]
    
    
    @IBOutlet var stepperButtons: [UIButton]!
    @IBOutlet var armButtons: [UIButton]!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var codeBackgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var stepperLabel: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(eV3ConnectSuccess), name: LMEV3ConnectSuccess, object: nil)
        lmManager.findEV3Accessory()
        themeUI()
        tableView.isEditing = true
        setupNextTask()
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
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        //        let _ = simpleTurn(isLeft: false)
        let command = MoveRightCommand(runFunction: simpleTurnRight)
        commands.append(command)
        tableView.reloadData()
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        //        let _ = moveRotations(forward: true)
        let command = MoveForwardCommand(runFunction: simpleForwardMove)
        commands.append(command)
        tableView.reloadData()
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        //        let _ = moveRotations(forward: false)
        let command = MoveBackwardCommand(runFunction: simpleBackwardMove)
        commands.append(command)
        tableView.reloadData()
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    @IBAction func armUp(_ sender: Any) {
        //let _ = moveArm(up: true)
        let command = ArmUpCommand(runFunction: simpleArmUp)
       commands.append(command)
       tableView.reloadData()
       SpeakTextManager.shared.speak("added \(command.directionText)")
     }
     
     @IBAction func armDown(_ sender: Any) {
       // let _ = moveArm(up: false)
        let command = ArmDownCommand(runFunction: simpleArmDown)
      commands.append(command)
      tableView.reloadData()
      SpeakTextManager.shared.speak("added \(command.directionText)")
     }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        //        lmManager.brick?.directCommand.stopMotor(onPorts: defaultPorts, withBrake: true)
    }
    
    @IBAction func instructionsButtonsPressed(_ sender: UIButton) {
        if let text = directionsLabel.text {
            SpeakTextManager.shared.speak(text)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let lastIdx = tasks.count - 1
        guard currentTaskIdx < lastIdx else { return }
        currentTaskIdx += 1
        setupNextTask()
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        guard currentTaskIdx > 0 else { return }
        currentTaskIdx -= 1
        setupNextTask()
    }
    
    @IBAction func goButtonsPressed(_ sender: UIButton) {
        //SpeakTextManager.shared.speak("Your code consists of ")
        runQueue()
    }
    
    @IBAction func checkButtonsPressed(_ sender: UIButton) {
        assesStudentWork()
    }
    
    @IBAction func minusStepper(_ sender: Any) {
    }
    
    @IBAction func addStepper(_ sender: Any) {
    }
    
 
    
    // MARK: - Private Methods
    @objc private func simpleArmUp() {
        let _ = moveArm(up: true)    }
    @objc private func simpleArmDown() {
        let _ = moveArm(up: false)
    }
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
    
    private func moveArm(_ rotations: Double = 1, up: Bool, shouldSend: Bool = true) -> Ev3Command {
        let command = Ev3Command(commandType: .directNoReply)
        let step: UInt32 = UInt32(30 * rotations)
        command.stepMotorAtSpeed(ports: armPorts,
                                 speed: up ? 25 : -25,
                                 steps: step,
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
        
        for button in armButtons {
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 8
            
        }
        
        for button in stepperButtons {
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 8
            
        }
    }
    
    private func runQueue() {
        userCanUseButton(false)
        
        for (idx, command) in commands.enumerated() {
            let delay =  (command.runLength * TimeInterval(idx))
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                SpeakTextManager.shared.speak(command.directionText)
                command.runFunction()
            }
        }
        let delay = commands.reduce(0) { (result, command) -> TimeInterval in
            return result + command.runLength
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.userCanUseButton(true)
        }
    }
    
    private func setupNextTask() {
        let task = tasks[currentTaskIdx]
        lessonTitleLabel.text = "Lesson \(task.lessonNum)"
        directionsLabel.text = task.directionsText
    }
    private func assesStudentWork() {
        let task = tasks[currentTaskIdx]
        let commandTypes = commands.map { type(of: $0) }
        guard (task.simpleAnswer.count == commandTypes.count) else {
            SpeakTextManager.shared.speak("There is an error in your code. Re-listen to what you currently have and revise your code.")
            return
        }
        var correct = true
        for (idx, answer) in task.simpleAnswer.enumerated() {
            let command = commandTypes[idx]
            if (answer != command){
                correct = false
                break
            }
        }
        
        SpeakTextManager.shared.speak(correct ? "Good job! There are no errors. Try running your code." : "There is an error in your code. Re-listen to what you currently have and revise your code.")
    }
    private func userCanUseButton(_ canUse: Bool) {
        goButton.isUserInteractionEnabled = canUse
        leftButton.isUserInteractionEnabled = canUse
        rightButton.isUserInteractionEnabled = canUse
        downButton.isUserInteractionEnabled = canUse
        upButton.isUserInteractionEnabled = canUse
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
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = commands[sourceIndexPath.row]
        commands.remove(at: sourceIndexPath.row)
        commands.insert(movedObject, at: destinationIndexPath.row)
    }
}
