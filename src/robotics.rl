#
Concrete Embedded Buses, wireless Protocols, Sensors, Actuators & Robotics
#

McuArchitecture      "AVR" | "ARM-Cortex-M0" | "ARM-Cortex-M4" | "ARM-Cortex-M7" | "RISC-V-RV32I" | "Xtensa-ESP32" | "MSP430"
HardwareBus          "I2C" | "SPI" | "UART" | "CAN-Bus" | "CAN-FD" | "Modbus-RTU" | "RS-485" | "1-Wire" | "PCIe" | "USB"
IotWirelessProtocol  "WiFi" | "BLE" | "Zigbee" | "Z-Wave" | "Thread" | "Matter" | "LoRaWAN" | "NB-IoT" | "LTE-M" | "5G-NR" | "UWB" | "NFC"
IotMessagingProtocol "MQTT" | "CoAP" | "AMQP" | "DDS-ROS2" | "LwM2M" | "WebSocket"
PinMode              "Input" | "InputPullUp" | "InputPullDown" | "OutputPushPull" | "OutputOpenDrain" | "Analog" | "Pwm"

SensorKind
  "Temperature" | "Humidity" | "BarometricPressure" | "Accelerometer" | "Gyroscope"
  | "Magnetometer" | "IMU-9DoF" | "GPS-GNSS" | "LiDAR-2D" | "LiDAR-3D" | "Radar"
  | "Ultrasonic" | "TimeOfFlight" | "OpticalCamera" | "ThermalCamera" | "EventCamera"
  | "GasCO2" | "ParticulateMatter" | "SoilMoisture" | "pH" | "ForceTorque" | "RotaryEncoder"

ImuMeasurement {
  LinearAcceleration VectorFloat3
  AngularVelocity    VectorFloat3
  MagneticField      VectorFloat3
  OrientationQuat    Quaternion
  Timestamp          Instant
}

LidarScanPoint {
  Position  Point3D
  Intensity Float
  Ring      Int
}

LidarPointCloud {
  FrameId   String
  Points    List(LidarScanPoint)
  Timestamp Instant
}

ActuatorKind "StepperMotor" | "BrushlessDC" | "BrushedDC" | "ServoMotor" | "LinearActuator" | "PneumaticValve" | "HydraulicCylinder" | "Solenoid" | "Relay" | "Piezoelectric"

StepPid(pid PidController, measured Float, dt Float) [
  Err        (Pid.Setpoint - Measured)
  NextInteg  (Pid.IntegralSum + (Err * Dt))
  Derivative ((Err - Pid.PrevError) / Dt)
  RawOutput  ((Pid.Kp * Err) + (Pid.Ki * NextInteg) + (Pid.Kd * Derivative))
  ClampedOut (RawOutput . Math.Clamp(Pid.OutputMin, Pid.OutputMax))
  {
    Controller    (Pid & { IntegralSum NextInteg, prevError Err })
    ControlSignal ClampedOut
  }
]

UpdateKalman1D(kf KalmanFilter1D, measurement Float) [
  KalmanGain (Kf.ErrorCovarianceP / (Kf.ErrorCovarianceP + Kf.MeasurementNoiseR))
  NextX      (Kf.EstimateX + KalmanGain * (Measurement - Kf.EstimateX))
  NextP      ((1.0 - KalmanGain) * Kf.ErrorCovarianceP + Kf.ProcessNoiseQ)
  Kf & { EstimateX NextX, errorCovarianceP NextP }
]

RobotJointType "Revolute" | "Continuous" | "Prismatic" | "Fixed" | "Floating" | "Planar"

DenavitHartenbergParam {
  LinkLengthA     Float
  LinkTwistAlpha  Float
  LinkOffsetD     Float
  JointAngleTheta Float
}

RobotJoint {
  Name          String
  JointType     RobotJointType
  ParentLink    String
  ChildLink     String
  Axis          VectorFloat3
  LowerLimitRad Float
  UpperLimitRad Float
  MaxEffortNm   Float
  MaxVelocity   Float
  DhParam       Option(DenavitHartenbergParam)
}

OccupancyCellState "Unknown" | "Free" | "Occupied"

OccupancyGrid2D {
  ResolutionMeters Float
  WidthCells       Int
  HeightCells      Int
  Origin           Pose
  Cells            List(OccupancyCellState)
}

RobotTrajectoryWaypoint {
  Pose          Pose
  Velocity      Vector3D
  TimeFromStart Duration
}

AutonomousRobot Robot & {
  DegreesOfFreedom Int
  Joints           List(RobotJoint)
  Sensors          List(SensorKind)
  BatteryLevel     Fraction
  NavigationMode   "Manual" | "Teleoperated" | "AutonomousSLAM" | "WaypointFollowing" | "EmergencyStop"
}

TriggerEmergencyStop(bot AutonomousRobot) [
  Bot & { NavigationMode "EmergencyStop" }
]

ToggleGpioPin(pin GpioPin & { Mode "OutputPushPull" }) [
  Pin & { LogicLevel (!Pin.LogicLevel) }
]
