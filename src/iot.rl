#
Abstract Embedded MCU, sensor Reading, actuator State, control Theory & Robotics
#

GpioPin {
  PinNumber  Int
  Mode       PinMode
  LogicLevel Bool
  VoltageRef Float
}

PwmChannel {
  ChannelId   Int
  FrequencyHz Float
  DutyCycle   Fraction
}

Microcontroller {
  Model          String
  Architecture   McuArchitecture
  ClockSpeedMhz  Float
  FlashSizeKb    Int
  SramSizeKb     Int
  GpioPins       List(GpioPin)
  OperatingVolts Float
  SleepPowerMw   Float
}

SensorReading {
  SensorId    String
  Kind        SensorKind
  Value       Float
  VectorValue Option(VectorFloat3)
  Unit        UnitSymbol
  Accuracy    Float
  Timestamp   Instant
}

MotorState {
  ActuatorId        String
  Kind              ActuatorKind
  TargetPositionRad Float
  ActualPositionRad Float
  VelocityRadPerSec Float
  TorqueNm          Float
  CurrentAmps       Float
  TemperatureC      Float
  IsEnabled         Bool
  FaultCode         Int
}

PidController {
  Kp          Float
  Ki          Float
  Kd          Float
  Setpoint    Float
  IntegralSum Float
  PrevError   Float
  OutputMin   Float
  OutputMax   Float
}

KalmanFilter1D {
  EstimateX         Float
  ErrorCovarianceP  Float
  ProcessNoiseQ     Float
  MeasurementNoiseR Float
}
