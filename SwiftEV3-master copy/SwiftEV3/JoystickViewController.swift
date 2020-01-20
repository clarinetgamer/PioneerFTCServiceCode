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
        directionsText: " Geronimo the robot is a priate collecting treasure. He starts at the point A1 on a grid. Go and collect the missing pirate treasure located at E4 on the grid.",
        complexAnswer: ("E", 4)),
//        Task(lessonNum: 3,
//               directionsText: "Ants",
//                simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self])
    ]
    var stepperCount: Int = 0 {
        didSet {
            guard (stepperCount != 0) else {
                stepperLabel.text = "#"
                return
            }
            stepperLabel.text = "\(stepperCount)"
        }
    }
    
    @IBOutlet var buttons: [UIButton]!
    
    var stepperButtons: [UIButton] {
        return [stepperAddButton, stepperMinusButton]
    }
    
    var armButtons: [UIButton] {
        return [armUpButton, armDownButton]
    }
    

    @IBOutlet weak var codeBackgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!

    
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    
    @IBOutlet weak var stepperAddButton: UIButton!
    @IBOutlet weak var stepperMinusButton: UIButton!
    
    @IBOutlet weak var armUpButton: UIButton!
    @IBOutlet weak var armDownButton: UIButton!
    
    @IBOutlet weak var instructionsButton: UIButton!

    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!


    


    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(eV3ConnectSuccess), name: LMEV3ConnectSuccess, object: nil)
        lmManager.findEV3Accessory()
        themeUI()
        tableView.isEditing = true
        setupNextTask()
        applyAccessibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            setupListeners()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeListeners()
    }
    

    // MARK: - Listeners
    private func setupListeners() {
        NotificationCenter.default.addObserver(self,selector: #selector(applicationDidBecomeActive),name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func removeListeners() {
        NotificationCenter.default.removeObserver(self,name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationDidBecomeActive() {
        if (UIAccessibility.isVoiceOverRunning) {
            instructionsButton.isHidden = true
            helpButton.isHidden = true

        } else {
            instructionsButton.isHidden = false
            helpButton.isHidden = false

        }
    }
    
    private func applyAccessibility() {
        //non changing buttons
        setupButton(goButton, text: "Run your code")
        setupButton(leftButton, text: "Add a left turn command")
        setupButton(rightButton, text: "Add a right turn command")
        setupButton(downButton, text: "Add a move backward command")
        setupButton(upButton, text: "Add a move forward command")
        setupButton(stepperAddButton, text: "Increase the count")
        setupButton(stepperMinusButton, text: "Decrease your count")
        setupButton(armUpButton, text: "Add an arm up command ")
        setupButton(armDownButton, text: "Add an arm down command ")
        setupButton(nextButton, text: "Go forward a lesson")
        setupButton(previousButton, text: "Go backward a lesson")

        //non changing labels
        setupLabel(stepperLabel, text: "Your current count is at \(stepperCount)")


    }
    
    private func setupButton(_ button: UIButton, text: String) {
        button.accessibilityTraits = .button
        button.accessibilityLabel = text
        
    }
    
    private func setupLabel(_ label: UILabel, text: String) {
        label.accessibilityLabel = text
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
        addCommand(command)
        tableView.reloadData()
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        //        let _ = simpleTurn(isLeft: false)
        let command = MoveRightCommand(runFunction: simpleTurnRight)
        addCommand(command)
        tableView.reloadData()
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        //        let _ = moveRotations(forward: true)
        let command = MoveForwardCommand(runFunction: simpleForwardMove)
        addCommand(command)
        tableView.reloadData()
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        //        let _ = moveRotations(forward: false)
        let command = MoveBackwardCommand(runFunction: simpleBackwardMove)
        addCommand(command)
        tableView.reloadData()
        SpeakTextManager.shared.speak("added \(command.directionText)")
        
    }
    @IBAction func armUp(_ sender: Any) {
        //let _ = moveArm(up: true)
        let command = ArmUpCommand(runFunction: simpleArmUp)
       addCommand(command)
       tableView.reloadData()
       SpeakTextManager.shared.speak("added \(command.directionText)")
     }
     
     @IBAction func armDown(_ sender: Any) {
       // let _ = moveArm(up: false)
        let command = ArmDownCommand(runFunction: simpleArmDown)
        addCommand(command)
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
        guard (stepperCount > 0) else {
            SpeakTextManager.shared.speak("The count cannot be lower than zero")
            return
        }
        
        stepperCount -= 1
        SpeakTextManager.shared.speak("Current count is \(stepperCount)")
    }
    
    @IBAction func addStepper(_ sender: Any) {
        stepperCount += 1
        SpeakTextManager.shared.speak("Current count is \(stepperCount)")
    }
    
 
    
    // MARK: - Private Methods
    private func addCommand(_ command: Command) {
        defer{
            stepperCount = 0
        }
        
        guard (stepperCount > 1) else {
            commands.append(command)
            return
        }
        
        for _ in (1...stepperCount) {
            commands.append(command)
        }
    }
    
    private func clearAllCommands() {
        commands = []
        tableView.reloadData()
    }
    
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
    
    private func simpleTurn(isLeft: Bool, rotations: Double = 1, shouldSend: Bool = true) -> Ev3Command {
        let command = Ev3Command(commandType: .directNoReply)
        let step: UInt32 = UInt32(175 * rotations)
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
        clearAllCommands()
    }
    private func assesStudentWork() {
        let task = tasks[currentTaskIdx]
        if let simpleAnswer = task.simpleAnswer {
            simpleAssess(simpleAnswer)
            return
        }
        if let complexAnswer = task.complexAnswer {
            complexAssess(complexAnswer)
            return
        }
        fatalError("You always need either a simple answer or complex answer")
    }
    
    private func simpleAssess(_ simpleAnswer: [Command.Type]) {
              let commandTypes = commands.map { type(of: $0) }
              guard (simpleAnswer.count == commandTypes.count) else {
                  SpeakTextManager.shared.speak("There is an error in your code. Re-listen to what you currently have and revise your code.")
                  return
              }
              var correct = true
              for (idx, answer) in simpleAnswer.enumerated() {
                  let command = commandTypes[idx]
                  if (answer != command){
                      correct = false
                      break
                  }
              }
              
              SpeakTextManager.shared.speak(correct ? "Good job! There are no errors. Try running your code." : "There is an error in your code. Re-listen to what you currently have and revise your code.")
    }
    
    private func complexAssess(_ complexAnswer: (String, Int)) {
        let userInput = postionForTask()
        
        // correct
        if (userInput == complexAnswer) {
             SpeakTextManager.shared.speak("Good job! There are no errors. Try running your code." )
        } else {
            // wrong
           SpeakTextManager.shared.speak("There is an error in your code. Re-listen to what you currently have and revise your code.")
        }
        
    }
    
    
    
    private func postionForTask() -> (String, Int) {
        var letterResult = 1 // A
        var numberResult = 1
        
        var currentDirection: FacingDirection = .forward
        
        for command in commands {
            switch command.id {
            case .left:
                currentDirection = currentDirection.turnLeft()
            case .right:
                currentDirection = currentDirection.turnRight()
            case .forward:
                switch currentDirection {
                case .left:
                    guard (letterResult > 0 && letterResult < 13) else { continue }
                    letterResult -= 1
                case .right:
                    guard (letterResult > 0 && letterResult < 13) else { continue }
                    letterResult += 1
                case .forward:
                    guard (numberResult > 0 && numberResult < 6) else { continue }
                    numberResult += 1
                case .backwards:
                    guard (numberResult > 0 && numberResult < 6) else { continue }
                    numberResult -= 1
                }
                
            case .backward:
                switch currentDirection {
                case .right:
                    guard (letterResult > 0 && letterResult < 13) else {
                        continue
                    }
                    letterResult -= 1
                case .left:
                    guard (letterResult > 0 && letterResult < 13) else {
                        continue
                    }
                    letterResult += 1
                case .backwards:
                    guard (numberResult > 0 && numberResult < 6) else {
                        continue
                    }
                    numberResult += 1
                case .forward:
                    guard (numberResult > 0 && numberResult < 6) else {
                        continue
                    }
                    numberResult -= 1
                }
                               
            case .armUp, .armDown:
                break
            }
            
            
        }
        
        return (letterResult.assiciatedLetter, numberResult)
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

extension Int {
    var assiciatedLetter: String {
        switch self {
        case 1: return "A"
        case 2: return "B"
        case 3: return "C"
        case 4: return "D"
        case 5: return "E"
        case 6: return "F"
        case 7: return "G"
        case 8: return "H"
        case 9: return "I"
        case 10: return "J"
        case 11: return "K"
        case 12: return "L"
            
        default:
            fatalError("This shouldn't happen...")
        }
        
    }
}

enum FacingDirection {
    case left, right, forward, backwards
    
    func turnLeft() -> FacingDirection {
        switch self {
        case .left: return .backwards
        case .right: return .forward
        case .forward: return .left
        case .backwards: return .right
        }
    }
    
    func turnRight() -> FacingDirection {
        switch self {
        case .left: return .forward
        case .right: return .backwards
        case .forward: return .right
        case .backwards: return .left
        }
    }

}
