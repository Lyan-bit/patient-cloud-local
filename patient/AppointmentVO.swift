
import Foundation

class AppointmentVO : Hashable, Identifiable, Decodable, Encodable {

  var appointmentId: String = ""
  var code: String = ""

  static var defaultInstance : AppointmentVO? = nil
  var errorList : [String] = [String]()

  init() {
  	//init
  }

  static func defaultAppointmentVO() -> AppointmentVO
  { if defaultInstance == nil
    { defaultInstance = AppointmentVO() }
    return defaultInstance!
  }

  init(appointmentIdx: String, codex: String)  {
    appointmentId = appointmentIdx
    code = codex
  }

  init(x : Appointment)  {
    appointmentId = x.appointmentId
    code = x.code
  }

  func toString() -> String
  { return " appointmentId= \(appointmentId), code= \(code) "
  }

  func getAppointmentId() -> String
	  { return appointmentId }
	
  func setAppointmentId(x : String)
	  { appointmentId = x }
	  
  func getCode() -> String
	  { return code }
	
  func setCode(x : String)
	  { code = x }
	  

  static func == (lhs: AppointmentVO, rhs: AppointmentVO) -> Bool
  { return
      lhs.appointmentId == rhs.appointmentId &&
      lhs.code == rhs.code
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(appointmentId)
    hasher.combine(code)
  }

}
