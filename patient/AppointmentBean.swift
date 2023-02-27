
import Foundation

class AppointmentBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreateAppointmentError(appointmentId: String, code: String) -> Bool { 
  	resetData() 
  	if appointmentId == "" {
  		errorList.append("appointmentId cannot be empty")
  	}
  	if code == "" {
  		errorList.append("code cannot be empty")
  	}

    return errorList.count > 0
  }

  func isEditAppointmentError() -> Bool
    { return false }
          
  func isListAppointmentError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeleteAppointmenterror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
