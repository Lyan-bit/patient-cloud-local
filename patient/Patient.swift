
import Foundation

class Patient : Decodable {
	
  private static var instance : Patient? = nil	
  
  init() { 
  	//init
  }
  
  init(copyFrom: Patient) {
  	self.patientId = "copy" + copyFrom.patientId
  	self.name = copyFrom.name
  	self.appointmentId = copyFrom.appointmentId
  	self.attends = copyFrom.attends
  }
  
  func copy() -> Patient
  { let res : Patient = Patient(copyFrom: self)
  	addPatient(instance: res)
  	return res
  }
  
static func defaultInstancePatient() -> Patient
    { if (instance == nil)
    { instance = createPatient() }
    return instance!
}

deinit
{ killPatient(obj: self) }	


  var patientId: String = ""  /* primary key */
  var name: String = "" 
  var appointmentId: String = "" 
    var attends : Appointment = Appointment.defaultInstanceAppointment()

  static var patientIndex : Dictionary<String,Patient> = [String:Patient]()

  static func getByPKPatient(index : String) -> Patient?
  { return patientIndex[index] }


}

  var PatientAllInstances : [Patient] = [Patient]()

  func createPatient() -> Patient
	{ let result : Patient = Patient()
	  PatientAllInstances.append(result)
	  return result }
  
  func addPatient(instance : Patient)
	{ PatientAllInstances.append(instance) }

  func killPatient(obj: Patient)
	{ PatientAllInstances = PatientAllInstances.filter{ $0 !== obj } }

  func createByPKPatient(key : String) -> Patient
	{ var result : Patient? = Patient.getByPKPatient(index: key)
	  if result != nil { 
	  	return result!
	  }
	  result = Patient()
	  PatientAllInstances.append(result!)
	  Patient.patientIndex[key] = result!
	  result!.patientId = key
	  return result! }

  func killPatient(key : String)
	{ Patient.patientIndex[key] = nil
	  PatientAllInstances.removeAll(where: { $0.patientId == key })
	}
	
	extension Patient : Hashable, Identifiable
	{ 
	  static func == (lhs: Patient, rhs: Patient) -> Bool
	  {       lhs.patientId == rhs.patientId &&
      lhs.name == rhs.name &&
      lhs.appointmentId == rhs.appointmentId
	  }
	
	  func hash(into hasher: inout Hasher) {
    	hasher.combine(patientId)
    	hasher.combine(name)
    	hasher.combine(appointmentId)
	  }
	}
	

