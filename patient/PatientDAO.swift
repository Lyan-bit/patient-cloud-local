import Foundation

class PatientDAO
{ static func getURL(command : String?, pars : [String], values : [String]) -> String
  { var res : String = "base url for the data source"
    if command != nil
    { res = res + command! }
    if pars.count == 0
    { return res }
    res = res + "?"
    for (i,v) in pars.enumerated()
    { res = res + v + "=" + values[i]
      if i < pars.count - 1
      { res = res + "&" }
    }
    return res
  }

  static func isCached(id : String) -> Bool
    { let x : Patient? = Patient.patientIndex[id]
    if x == nil 
    { return false }
    return true
  }

  static func getCachedInstance(id : String) -> Patient
    { return Patient.patientIndex[id]! }

  static func parseCSV(line: String) -> Patient?
  { if line.count == 0
    { return nil }
    let line1vals : [String] = Ocl.tokeniseCSV(line: line)
    var patientx : Patient? = nil
      patientx = Patient.patientIndex[line1vals[0]]
    if patientx == nil
    { patientx = createByPKPatient(key: line1vals[0]) }
    patientx!.patientId = line1vals[0]
    patientx!.name = line1vals[1]
    patientx!.appointmentId = line1vals[2]

    return patientx
  }

  static func parseJSON(obj : [String : AnyObject]?) -> Patient?
  {

    if let jsonObj = obj
    { let id : String? = jsonObj["patientId"] as! String?
      var patientx : Patient? = Patient.patientIndex[id!]
      if (patientx == nil)
      { patientx = createByPKPatient(key: id!) }

       patientx!.patientId = jsonObj["patientId"] as! String
       patientx!.name = jsonObj["name"] as! String
       patientx!.appointmentId = jsonObj["appointmentId"] as! String
      return patientx!
    }
    return nil
  }

  static func writeJSON(x : Patient) -> NSDictionary
  { return [    
       "patientId": x.patientId as NSString, 
       "name": x.name as NSString, 
       "appointmentId": x.appointmentId as NSString
     ]
  } 

  static func makeFromCSV(lines: String) -> [Patient]
  { var res : [Patient] = [Patient]()

    if lines.count == 0
    { return res }

    let rows : [String] = Ocl.parseCSVtable(rows: lines)

    for (_,row) in rows.enumerated()
    { if row.count == 0 {
    	//check
    }
      else
      { let x : Patient? = parseCSV(line: row)
        if (x != nil)
        { res.append(x!) }
      }
    }
    return res
  }
}

