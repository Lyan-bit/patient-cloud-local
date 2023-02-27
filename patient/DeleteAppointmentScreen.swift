
import SwiftUI

struct DeleteAppointmentScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
            HStack (spacing: 20) {
             	Text("appointmentId:").bold()
             	Divider()
		        Picker("Appointment", selection: $objectId) { 
		        	ForEach(model.currentAppointments) { Text($0.appointmentId).tag($0.appointmentId) }
		        }.pickerStyle(.menu)
		    }.frame(width: 200, height: 30).border(Color.gray)

        HStack(spacing: 20) {
            Button(action: { self.model.deleteAppointment(id: objectId) } ) { Text("Delete") }
			Button(action: { self.model.cancelDeleteAppointment() } ) { Text("Cancel") }
        }.buttonStyle(.bordered)
      }.padding(.top).onAppear(perform:
        {   objectId = model.currentAppointment?.appointmentId ?? "appointmentId" 
        	model.listAppointment()
        })
        }.navigationTitle("Delete Appointment")
       }
    } 
}

struct DeleteAppointmentScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAppointmentScreen(model: ModelFacade.getInstance())
    }
}

