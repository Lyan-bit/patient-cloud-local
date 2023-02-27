import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseDB
{ static var instance : FirebaseDB? = nil
  var database : DatabaseReference? = nil

  static func getInstance() -> FirebaseDB
  { if instance == nil
    { instance = FirebaseDB() }
    return instance!
  }

  init() {
	  //cloud database link
      connectByURL("https://patient-161e1-default-rtdb.europe-west1.firebasedatabase.app/")
  }

  func connectByURL(_ url: String)
  { self.database = Database.database(url: url).reference()
    if self.database == nil
    { print("Invalid database url")
      return
    }
    self.database?.child("patients").observe(.value,
      with:
      { (change) in
        var keys : [String] = [String]()
        if let d = change.value as? [String : AnyObject]
        { for (_,v) in d.enumerated()
          { let einst = v.1 as! [String : AnyObject]
            let ex : Patient? = PatientDAO.parseJSON(obj: einst)
            keys.append(ex!.patientId)
          }
        }
        var runtimepatients : [Patient] = [Patient]()
        runtimepatients.append(contentsOf: PatientAllInstances)

        for (_,obj) in runtimepatients.enumerated()
        { if keys.contains(obj.patientId) {
        	//check
        }
          else
          { killPatient(key: obj.patientId) }
        }
      })
  }

func persistPatient(x: Patient)
{ let evo = PatientDAO.writeJSON(x: x) 
  if let newChild = self.database?.child("patients").child(x.patientId)
  { newChild.setValue(evo) }
}

func deletePatient(x: Patient)
{ if let oldChild = self.database?.child("patients").child(x.patientId)
  { oldChild.removeValue() }
}

}
