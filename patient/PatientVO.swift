
import Foundation

class PatientVO : Hashable, Identifiable, Decodable, Encodable {

  var patientId: String = ""
  var name: String = ""
  var appointmentId: String = ""

  static var defaultInstance : PatientVO? = nil
  var errorList : [String] = [String]()

  init() {
  	//init
  }

  static func defaultPatientVO() -> PatientVO
  { if defaultInstance == nil
    { defaultInstance = PatientVO() }
    return defaultInstance!
  }

  init(patientIdx: String, namex: String, appointmentIdx: String)  {
    patientId = patientIdx
    name = namex
    appointmentId = appointmentIdx
  }

  init(x : Patient)  {
    patientId = x.patientId
    name = x.name
    appointmentId = x.appointmentId
  }

  func toString() -> String
  { return " patientId= \(patientId), name= \(name), appointmentId= \(appointmentId) "
  }

  func getPatientId() -> String
	  { return patientId }
	
  func setPatientId(x : String)
	  { patientId = x }
	  
  func getName() -> String
	  { return name }
	
  func setName(x : String)
	  { name = x }
	  
  func getAppointmentId() -> String
	  { return appointmentId }
	
  func setAppointmentId(x : String)
	  { appointmentId = x }
	  

  static func == (lhs: PatientVO, rhs: PatientVO) -> Bool
  { return
      lhs.patientId == rhs.patientId &&
      lhs.name == rhs.name &&
      lhs.appointmentId == rhs.appointmentId
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(patientId)
    hasher.combine(name)
    hasher.combine(appointmentId)
  }

}
