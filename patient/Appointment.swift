
import Foundation

class Appointment : Decodable {
	
  private static var instance : Appointment? = nil	
  
  init() { 
  	//init
  }
  
  init(copyFrom: Appointment) {
  	self.appointmentId = "copy" + copyFrom.appointmentId
  	self.code = copyFrom.code
  }
  
  func copy() -> Appointment
  { let res : Appointment = Appointment(copyFrom: self)
  	addAppointment(instance: res)
  	return res
  }
  
static func defaultInstanceAppointment() -> Appointment
    { if (instance == nil)
    { instance = createAppointment() }
    return instance!
}

deinit
{ killAppointment(obj: self) }	


  var appointmentId: String = ""  /* primary key */
  var code: String = "" 
    var patients : Set<Patient> = []

  static var appointmentIndex : Dictionary<String,Appointment> = [String:Appointment]()

  static func getByPKAppointment(index : String) -> Appointment?
  { return appointmentIndex[index] }


}

  var AppointmentAllInstances : [Appointment] = [Appointment]()

  func createAppointment() -> Appointment
	{ let result : Appointment = Appointment()
	  AppointmentAllInstances.append(result)
	  return result }
  
  func addAppointment(instance : Appointment)
	{ AppointmentAllInstances.append(instance) }

  func killAppointment(obj: Appointment)
	{ AppointmentAllInstances = AppointmentAllInstances.filter{ $0 !== obj } }

  func createByPKAppointment(key : String) -> Appointment
	{ var result : Appointment? = Appointment.getByPKAppointment(index: key)
	  if result != nil { 
	  	return result!
	  }
	  result = Appointment()
	  AppointmentAllInstances.append(result!)
	  Appointment.appointmentIndex[key] = result!
	  result!.appointmentId = key
	  return result! }

  func killAppointment(key : String)
	{ Appointment.appointmentIndex[key] = nil
	  AppointmentAllInstances.removeAll(where: { $0.appointmentId == key })
	}
	
	extension Appointment : Hashable, Identifiable
	{ 
	  static func == (lhs: Appointment, rhs: Appointment) -> Bool
	  {       lhs.appointmentId == rhs.appointmentId &&
      lhs.code == rhs.code
	  }
	
	  func hash(into hasher: inout Hasher) {
    	hasher.combine(appointmentId)
    	hasher.combine(code)
	  }
	}
	

