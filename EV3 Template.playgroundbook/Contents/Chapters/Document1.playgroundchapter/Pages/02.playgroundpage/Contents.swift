//#-hidden-code
import PlaygroundSupport
import Foundation

let ev3 = PlaygroundPageSupport.createRobot()
//#-end-hidden-code
/*:#localized(key: "FirstProseBlock")
  Let's make sure you can connect, and that you understand the basics of the API.

  ### Build

  Grab your EV3 Brick, a Large Motor, and a Touch Sensor! Connect the sensor to Port 4 and connect the motor to Port A. Now tap *Connect EV3 Brick* to pair it to your iPad.

  ![Large Motor and Touch Sensor Connected](45544_Turtle_EV3_15.jpg)

  ### Analyze

  Once you are connected, tap *Run my Code* and observe what happens. You should see that pressing the Touch Sensor powers the Large Motor on. It will be powered off when you release the Touch Sensor. If you're having trouble, refer to *How do I connect?* for help.
  */
//#-editable-code
while true {
    ev3.waitForTouch(on: .four)
    ev3.motorOn(on: .a, withPower: 100.0)
    ev3.waitForTouchReleased(on: .four)
    ev3.motorOff(on: .a, brakeAtEnd: false)
}
//#-end-editable-code
