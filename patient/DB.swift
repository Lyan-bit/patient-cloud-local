import Foundation
import SQLite3

/* Code adapted from https://www.raywenderlich.com/6620276-sqlite-with-swift-tutorial-getting-started */

class DB {
  let dbPointer : OpaquePointer?
  static let dbName = "patientApp.db"
  static let dbVersion = 1

  static let appointmentTableName = "Appointment"
  static let appointmentID = 0
  static let appointmentCols : [String] = ["TableId", "appointmentId", "code"]
  static let appointmentNumberCols = 0

  static let appointmentCreateSchema =
    "create table Appointment (TableId integer primary key autoincrement" + 
        ", appointmentId VARCHAR(50) not null"  +
        ", code VARCHAR(50) not null"  +
	"" + ")"
	
  private init(dbPointer: OpaquePointer?)
  { self.dbPointer = dbPointer }

  func createDatabase() throws
  { do 
    { 
    try createTable(table: DB.appointmentCreateSchema)
      print("Created database")
    }
    catch { print("Errors: " + errorMessage) }
  }

  static func obtainDatabase(path: String) -> DB?
  {
    var db : DB? = nil
    if FileAccessor.fileExistsAbsolutePath(filename: path)
    { print("Database already exists")
      do
      { try db = DB.open(path: path)
        if db != nil
        { print("Opened database") }
        else
        { print("Failed to open existing database") }
      }
      catch { print("Error opening existing database") 
              return nil 
            }
    }
    else
    { print("New database will be created")
      do
      { try db = DB.open(path: path)
        if db != nil
        { print("Opened new database") 
          try db!.createDatabase() 
        }
        else
        { print("Failed to open new database") }
      }
      catch { print("Error opening new database")  
              return nil }
    }
    return db
  }

  fileprivate var errorMessage: String
  { if let errorPointer = sqlite3_errmsg(dbPointer)
    { let eMessage = String(cString: errorPointer)
      return eMessage
    } 
    else 
    { return "Unknown error from sqlite." }
  }
  
  func prepareStatement(sql: String) throws -> OpaquePointer?   
  { var statement: OpaquePointer?
    guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) 
        == SQLITE_OK
    else 
    { return nil }
    return statement
  }
  
  static func open(path: String) throws -> DB? 
  { var db: OpaquePointer?
  
    if sqlite3_open(path, &db) == SQLITE_OK 
    { return DB(dbPointer: db) }
    else 
    { defer 
      { if db != nil 
        { sqlite3_close(db) }
      }
  
      if let errorPointer = sqlite3_errmsg(db)
      { let message = String(cString: errorPointer)
        print("Error opening database: " + message)
      } 
      else 
      { print("Unknown error opening database") }
      return nil
    }
  }
  
  func createTable(table: String) throws
  { let createTableStatement = try prepareStatement(sql: table)
    defer 
    { sqlite3_finalize(createTableStatement) }
    
    guard sqlite3_step(createTableStatement) == SQLITE_DONE 
    else
    { print("Error creating table") 
      return
    }
    print("table " + table + " created.")
  }

  func listAppointment() -> [AppointmentVO]
  { 
  	let statement = "SELECT * FROM Appointment "
  	return setDataAppointment(statement: statement)
  }

  func createAppointment(appointmentvo : AppointmentVO) throws
  { let insertSQL : String = "INSERT INTO Appointment (appointmentId, code) VALUES (" 

     + "'" + appointmentvo.getAppointmentId() + "'" + "," 
     + "'" + appointmentvo.getCode() + "'"
      + ")"
    let insertStatement = try prepareStatement(sql: insertSQL)
    defer 
    { sqlite3_finalize(insertStatement)
    }
    sqlite3_step(insertStatement)
  }

  func searchByAppointmentappointmentId(val : String) -> [AppointmentVO]
	  { 
	  	let statement : String = "SELECT * FROM Appointment WHERE appointmentId = " + "'" + val + "'" 
	  	return setDataAppointment(statement: statement)
	  }
	  
  func searchByAppointmentcode(val : String) -> [AppointmentVO]
	  { 
	  	let statement : String = "SELECT * FROM Appointment WHERE code = " + "'" + val + "'" 
	  	return setDataAppointment(statement: statement)
	  }
	  

  func editAppointment(appointmentvo : AppointmentVO)
  { var updateStatement: OpaquePointer?
    let statement : String = "UPDATE Appointment SET " 
    + " code = '"+appointmentvo.getCode() + "'" 
    + " WHERE appointmentId = '" + appointmentvo.getAppointmentId() + "'" 

    if sqlite3_prepare_v2(dbPointer, statement, -1, &updateStatement, nil) == SQLITE_OK
    { sqlite3_step(updateStatement) }
    sqlite3_finalize(updateStatement)
  }

  func deleteAppointment(val : String)
  { let deleteStatementString = "DELETE FROM Appointment WHERE appointmentId = '" + val + "'"
    var deleteStatement: OpaquePointer?
    
    if sqlite3_prepare_v2(dbPointer, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK
    { sqlite3_step(deleteStatement) }
    sqlite3_finalize(deleteStatement)
  }


  deinit
  { sqlite3_close(self.dbPointer) }

  func setDataAppointment(statement: String) -> [AppointmentVO] {
          var res : [AppointmentVO] = [AppointmentVO]()
          let queryStatement = try? prepareStatement(sql: statement)
          
          while (sqlite3_step(queryStatement) == SQLITE_ROW)
          { 
            let appointmentvo = AppointmentVO()
            
	      guard let queryResultAppointmentColAppointmentId = sqlite3_column_text(queryStatement, 4)
			      else { return res }	      
			      let appointmentId = String(cString: queryResultAppointmentColAppointmentId)
			      appointmentvo.setAppointmentId(x: appointmentId)
	      guard let queryResultAppointmentColCode = sqlite3_column_text(queryStatement, 5)
			      else { return res }	      
			      let code = String(cString: queryResultAppointmentColCode)
			      appointmentvo.setCode(x: code)
  
            res.append(appointmentvo)
          }
          sqlite3_finalize(queryStatement)
          return res
      }
      
}

