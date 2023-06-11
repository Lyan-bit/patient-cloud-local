	                  
import Foundation
import SwiftUI


func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
if typeName == "Patient"
  { let x = try? decoder.decode(Patient.self, from: jdata) 
  return x
}
if typeName == "Appointment"
  { let x = try? decoder.decode(Appointment.self, from: jdata) 
  return x
}
  return nil
	}

class ModelFacade : ObservableObject {
		                      
	static var instance : ModelFacade? = nil
	var cdb : FirebaseDB = FirebaseDB.getInstance()
	var db : DB?
		
	// path of document directory for SQLite database (absolute path of db)
	let dbpath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> ModelFacade { 
		if instance == nil
	     { instance = ModelFacade() 
         }
	    return instance! }
	                          
	init() { 
		// init
		db = DB.obtainDatabase(path: "\(dbpath)/myDatabase.sqlite3")
		loadAppointment()
	}
	      
	@Published var currentPatient : PatientVO? = PatientVO.defaultPatientVO()
	@Published var currentPatients : [PatientVO] = [PatientVO]()
	@Published var currentAppointment : AppointmentVO? = AppointmentVO.defaultAppointmentVO()
	@Published var currentAppointments : [AppointmentVO] = [AppointmentVO]()

		func createPatient(x : PatientVO) {
		    if let obj = getPatientByPK(val: x.patientId)
			{ cdb.persistPatient(x: obj) }
			else {
			let item : Patient = createByPKPatient(key: x.patientId)
		      item.patientId = x.getPatientId()
		      item.name = x.getName()
		      item.appointmentId = x.getAppointmentId()
			cdb.persistPatient(x: item)
			}
			currentPatient = x
	}
			
	func cancelCreatePatient() {
		//cancel function
	}
	
	func deletePatient(id : String) {
		if let obj = getPatientByPK(val: id)
		{ cdb.deletePatient(x: obj) }
	}
		
	func cancelDeletePatient() {
		//cancel function
	}
	
	func cancelEditPatient() {
		//cancel function
	}

	func createAppointment(x : AppointmentVO) {
		let res : Appointment = createByPKAppointment(key: x.appointmentId)
			res.appointmentId = x.appointmentId
		res.code = x.code
	    currentAppointment = x

	    do { try db?.createAppointment(appointmentvo: x) }
	    catch { print("Error creating Appointment") }
	}
	
	func cancelCreateAppointment() {
		//cancel function
	}

	func cancelEditAppointment() {
	//cancel function
}

	func deleteAppointment(id : String) {
		 if db != nil
	      { db!.deleteAppointment(val: id) }
	     	currentAppointment = nil
	}
		
	func cancelDeleteAppointment() {
		//cancel function
	}
	
  func addPatientattendsAppointment(x: String, y: String) {
		if let obj = getPatientByPK(val: y) {
		obj.appointmentId = x
		cdb.persistPatient(x: obj)
		}
	}
	
	func cancelAddPatientattendsAppointment() {
		//cancel function
	}
	
  func removePatientattendsAppointment(x: String, y: String) {
		if let obj = getPatientByPK(val: y) {
		obj.appointmentId = "NULL"
		cdb.persistPatient(x: obj)
		}
	}
		
	func cancelRemovePatientattendsAppointment() {
		//cancel function
	}


	func loadAppointment() {
		let res : [AppointmentVO] = listAppointment()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKAppointment(key: x.appointmentId)
	        obj.appointmentId = x.getAppointmentId()
        obj.code = x.getCode()
			}
		 currentAppointment = res.first
		 currentAppointments = res
		}
		
  		func listAppointment() -> [AppointmentVO] {
			if db != nil
			{ currentAppointments = (db?.listAppointment())!
			  return currentAppointments
			}
			currentAppointments = [AppointmentVO]()
			let list : [Appointment] = AppointmentAllInstances
			for (_,x) in list.enumerated()
			{ currentAppointments.append(AppointmentVO(x: x)) }
			return currentAppointments
		}
				
		func stringListAppointment() -> [String] { 
			currentAppointments = listAppointment()
			var res : [String] = [String]()
			for (_,obj) in currentAppointments.enumerated()
			{ res.append(obj.toString()) }
			return res
		}
				
		func getAppointmentByPK(val: String) -> Appointment? {
			var res : Appointment? = Appointment.getByPKAppointment(index: val)
			if res == nil && db != nil
			{ let list = db!.searchByAppointmentappointmentId(val: val)
			if list.count > 0
			{ res = createByPKAppointment(key: val)
			}
		  }
		  return res
		}
				
		func retrieveAppointment(val: String) -> Appointment? {
			let res : Appointment? = getAppointmentByPK(val: val)
			return res 
		}
				
		func allAppointmentids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentAppointments.enumerated()
			{ res.append(item.appointmentId + "") }
			return res
		}
				
		func setSelectedAppointment(x : AppointmentVO)
			{ currentAppointment = x }
				
		func setSelectedAppointment(i : Int) {
			if 0 <= i && i < currentAppointments.count
			{ currentAppointment = currentAppointments[i] }
		}
				
		func getSelectedAppointment() -> AppointmentVO?
			{ return currentAppointment }
				
		func persistAppointment(x : Appointment) {
			let vo : AppointmentVO = AppointmentVO(x: x)
			editAppointment(x: vo)
		}
			
		func editAppointment(x : AppointmentVO) {
			let val : String = x.appointmentId
			let res : Appointment? = Appointment.getByPKAppointment(index: val)
			if res != nil {
			res!.appointmentId = x.appointmentId
		res!.code = x.code
		}
		currentAppointment = x
			if db != nil
			 { db!.editAppointment(appointmentvo: x) }
		 }
			
	    func cancelAppointmentEdit() {
	    	//cancel function
	    }
	    
 	func searchByAppointmentappointmentId(val : String) -> [AppointmentVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByAppointmentappointmentId(val: val))!
		          return res
		        }
		    currentAppointments = [AppointmentVO]()
		    let list : [Appointment] = AppointmentAllInstances
		    for (_,x) in list.enumerated()
		    { if x.appointmentId == val
		      { currentAppointments.append(AppointmentVO(x: x)) }
		    }
		    return currentAppointments
		  }
		  
 	func searchByAppointmentcode(val : String) -> [AppointmentVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByAppointmentcode(val: val))!
		          return res
		        }
		    currentAppointments = [AppointmentVO]()
		    let list : [Appointment] = AppointmentAllInstances
		    for (_,x) in list.enumerated()
		    { if x.code == val
		      { currentAppointments.append(AppointmentVO(x: x)) }
		    }
		    return currentAppointments
		  }
		  

    func listPatient() -> [PatientVO] {
		currentPatients = [PatientVO]()
		let list : [Patient] = PatientAllInstances
		for (_,x) in list.enumerated()
		{ currentPatients.append(PatientVO(x: x)) }
		return currentPatients
	}
			
	func loadPatient() {
		let res : [PatientVO] = listPatient()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKPatient(key: x.patientId)
	        obj.patientId = x.getPatientId()
        obj.name = x.getName()
        obj.appointmentId = x.getAppointmentId()
			}
		 currentPatient = res.first
		 currentPatients = res
	}
		
	func stringListPatient() -> [String] { 
		var res : [String] = [String]()
		for (_,obj) in currentPatients.enumerated()
		{ res.append(obj.toString()) }
		return res
	}
			
    func searchByPatientpatientId(val : String) -> [PatientVO] {
	    var resultList: [PatientVO] = [PatientVO]()
	    let list : [Patient] = PatientAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.patientId == val) {
	    		resultList.append(PatientVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByPatientname(val : String) -> [PatientVO] {
	    var resultList: [PatientVO] = [PatientVO]()
	    let list : [Patient] = PatientAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.name == val) {
	    		resultList.append(PatientVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByPatientappointmentId(val : String) -> [PatientVO] {
	    var resultList: [PatientVO] = [PatientVO]()
	    let list : [Patient] = PatientAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.appointmentId == val) {
	    		resultList.append(PatientVO(x: x))
	    	}
	    }
	  return resultList
	}
	
		
	func getPatientByPK(val: String) -> Patient?
		{ return Patient.patientIndex[val] }
			
	func retrievePatient(val: String) -> Patient?
			{ return Patient.patientIndex[val] }
			
	func allPatientids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentPatients.enumerated()
			{ res.append(item.patientId + "") }
			return res
	}
			
	func setSelectedPatient(x : PatientVO)
		{ currentPatient = x }
			
	func setSelectedPatient(i : Int) {
		if i < currentPatients.count
		{ currentPatient = currentPatients[i] }
	}
			
	func getSelectedPatient() -> PatientVO?
		{ return currentPatient }
			
	func persistPatient(x : Patient) {
		let vo : PatientVO = PatientVO(x: x)
		cdb.persistPatient(x: x)
		currentPatient = vo
	}
		
	func editPatient(x : PatientVO) {
		if let obj = getPatientByPK(val: x.patientId) {
		 obj.patientId = x.getPatientId()
		 obj.name = x.getName()
		 obj.appointmentId = x.getAppointmentId()
		cdb.persistPatient(x: obj)
		}
	    currentPatient = x
	}
			
	}
