_ primitive
_ structure
_ math
_ quantity
_ time
_ space
_ energy
_ artifact

#
1. Embedded Microcontrollers, Buses & Wireless Protocols
#

McuArchitecture "AVR" | "ARM-Cortex-M0" | "ARM-Cortex-M4" | "ARM-Cortex-M7" | "RISC-V-RV32I" | "Xtensa-ESP32" | "MSP430"
HardwareBus "I2C" | "SPI" | "UART" | "CAN-Bus" | "CAN-FD" | "Modbus-RTU" | "RS-485" | "1-Wire" | "PCIe" | "USB"
IotWirelessProtocol "WiFi" | "BLE" | "Zigbee" | "Z-Wave" | "Thread" | "Matter" | "LoRaWAN" | "NB-IoT" | "LTE-M" | "5G-NR" | "UWB" | "NFC"
IotMessagingProtocol "MQTT" | "CoAP" | "AMQP" | "DDS-ROS2" | "LwM2M" | "WebSocket"

PinMode "Input" | "InputPullUp" | "InputPullDown" | "OutputPushPull" | "OutputOpenDrain" | "Analog" | "Pwm"

GpioPin {
  PinNumber   Int
  Mode        PinMode
  LogicLevel  Bool
  VoltageRef  Float
}

PwmChannel {
  ChannelId   Int
  FrequencyHz Float
  DutyCycle   Fraction
}

Microcontroller {
  Model           String
  Architecture    McuArchitecture
  ClockSpeedMhz   Float
  FlashSizeKb     Int
  SramSizeKb      Int
  GpioPins        List(GpioPin)
  OperatingVolts  Float
  SleepPowerMw    Float
}

#
2. Sensors & Telemetry Readings
#

SensorKind
  "Temperature" | "Humidity" | "BarometricPressure" | "Accelerometer" | "Gyroscope"
  | "Magnetometer" | "IMU-9DoF" | "GPS-GNSS" | "LiDAR-2D" | "LiDAR-3D" | "Radar"
  | "Ultrasonic" | "TimeOfFlight" | "OpticalCamera" | "ThermalCamera" | "EventCamera"
  | "GasCO2" | "ParticulateMatter" | "SoilMoisture" | "pH" | "ForceTorque" | "RotaryEncoder"

SensorReading {
  SensorId    String
  Kind        SensorKind
  Value       Float
  VectorValue Option(VectorFloat3)
  Unit        UnitSymbol
  Accuracy    Float
  Timestamp   Instant
}

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

#
3. Actuators, Motors & End-Effectors
#

ActuatorKind "StepperMotor" | "BrushlessDC" | "BrushedDC" | "ServoMotor" | "LinearActuator" | "PneumaticValve" | "HydraulicCylinder" | "Solenoid" | "Relay" | "Piezoelectric"

MotorState {
  ActuatorId       String
  Kind             ActuatorKind
  TargetPositionRad Float
  ActualPositionRad Float
  VelocityRadPerSec Float
  TorqueNm         Float
  CurrentAmps      Float
  TemperatureC     Float
  IsEnabled        Bool
  FaultCode        Int
}

#
4. Control Theory: PID Controller & Kalman Filter
#

PidController {
  Kp           Float
  Ki           Float
  Kd           Float
  Setpoint     Float
  IntegralSum  Float
  PrevError    Float
  OutputMin    Float
  OutputMax    Float
}

StepPid(Pid PidController,Measured Float, Dt Float) [
  Err        (Pid.Setpoint - Measured)
  NextInteg  (Pid.IntegralSum + (Err * Dt))
  Derivative ((Err - Pid.PrevError) / Dt)
  RawOutput  ((Pid.Kp * Err) + (Pid.Ki * NextInteg) + (Pid.Kd * Derivative))
  ClampedOut (RawOutput . Math.Clamp(Pid.OutputMin, Pid.OutputMax))
  {
    Controller (Pid & { IntegralSum NextInteg, PrevError Err })
    ControlSignal ClampedOut
  }
]

KalmanFilter1D {
  EstimateX          Float
  ErrorCovarianceP   Float
  ProcessNoiseQ      Float
  MeasurementNoiseR  Float
}

UpdateKalman1D(Kf KalmanFilter1D, Measurement Float) [
  KalmanGain (Kf.ErrorCovarianceP / (Kf.ErrorCovarianceP + Kf.MeasurementNoiseR))
  NextX      (Kf.EstimateX + KalmanGain * (Measurement - Kf.EstimateX))
  NextP      ((1.0 - KalmanGain) * Kf.ErrorCovarianceP + Kf.ProcessNoiseQ)
  Kf & { EstimateX NextX, ErrorCovarianceP NextP }
]

#
5. Robotics, Kinematics (DH / URDF), SLAM & Autonomous Navigation
#

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

#
6. IoT & Robotics Transitions
#

TriggerEmergencyStop(Bot AutonomousRobot) [
  Bot & { NavigationMode "EmergencyStop" }
]

ToggleGpioPin(Pin GpioPin & { Mode "OutputPushPull" }) [
  Pin & { LogicLevel (!Pin.LogicLevel) }
]
