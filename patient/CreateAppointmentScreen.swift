
import SwiftUI

struct CreateAppointmentScreen: View {
 
  @State var bean : AppointmentVO = AppointmentVO()
  @ObservedObject var model : ModelFacade

  var body: some View {
  	NavigationView {
  		ScrollView {
  	VStack(spacing: 20) {

		HStack (spacing: 20) {
		Text("AppointmentId:").bold()
		TextField("AppointmentId", text: $bean.appointmentId).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Code:").bold()
		TextField("Code", text: $bean.code).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)


      HStack(spacing: 20) {
        Button(action: { 
        	self.model.createAppointment(x: bean)
        } ) { Text("Create") }
        Button(action: { self.model.cancelCreateAppointment() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top)
     }.navigationTitle("Create Appointment")
    }
  }
}

struct CreateAppointmentScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAppointmentScreen(model: ModelFacade.getInstance())
    }
}

