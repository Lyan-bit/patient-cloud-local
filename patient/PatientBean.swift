
import Foundation

class PatientBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreatePatientError(patientId: String, name: String, appointmentId: String) -> Bool { 
  	resetData() 
  	if patientId == "" {
  		errorList.append("patientId cannot be empty")
  	}
  	if name == "" {
  		errorList.append("name cannot be empty")
  	}
  	if appointmentId == "" {
  		errorList.append("appointmentId cannot be empty")
  	}

    return errorList.count > 0
  }

  func isEditPatientError() -> Bool
    { return false }
          
  func isListPatientError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeletePatienterror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
