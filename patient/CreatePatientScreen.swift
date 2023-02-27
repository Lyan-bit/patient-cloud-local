
import SwiftUI

struct CreatePatientScreen: View {
 
  @State var bean : PatientVO = PatientVO()
  @ObservedObject var model : ModelFacade

  var body: some View {
  	NavigationView {
  		ScrollView {
  	VStack(spacing: 20) {

		HStack (spacing: 20) {
		Text("PatientId:").bold()
		TextField("PatientId", text: $bean.patientId).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Name:").bold()
		TextField("Name", text: $bean.name).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("AppointmentId:").bold()
		TextField("AppointmentId", text: $bean.appointmentId).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)


      HStack(spacing: 20) {
        Button(action: { 
        	self.model.createPatient(x: bean)
        } ) { Text("Create") }
        Button(action: { self.model.cancelCreatePatient() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top)
     }.navigationTitle("Create Patient")
    }
  }
}

struct CreatePatientScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreatePatientScreen(model: ModelFacade.getInstance())
    }
}

