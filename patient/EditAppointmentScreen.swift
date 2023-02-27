
import SwiftUI

struct EditAppointmentScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    @State var bean : Appointment = Appointment()
    
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
      	HStack (spacing: 20) {
      	Text("appointmentId:")
      	Divider()
        Picker("Appointment", selection: $objectId) { 
        	ForEach(model.currentAppointments) { Text($0.appointmentId).tag($0.appointmentId) }
        }.pickerStyle(.menu)
        }.frame(width: 200, height: 30).border(Color.gray)
		      HStack (spacing: 20) {
		        Text("AppointmentId:").bold()
		        TextField("AppointmentId", text: $bean.appointmentId).textFieldStyle(RoundedBorderTextFieldStyle())
		      }.frame(width: 200, height: 30).border(Color.gray)

		      HStack (spacing: 20) {
		        Text("Code:").bold()
		        TextField("Code", text: $bean.code).textFieldStyle(RoundedBorderTextFieldStyle())
		      }.frame(width: 200, height: 30).border(Color.gray)


HStack (spacing: 20) {
		Button(action: { 
	bean = model.getAppointmentByPK(val: objectId) ?? bean
		} ) { Text("Search") }
        Button(action: { 
        	self.model.editAppointment(x: AppointmentVO(x: bean))
        } ) { Text("Edit") }
        Button(action: { self.model.cancelEditAppointment() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top)
    .onAppear(perform:
            {   objectId = model.currentAppointment?.appointmentId ?? "id" 
            	model.listAppointment()
            })
    	}.navigationTitle("Edit Appointment")
     }
  }
}

struct EditAppointmentScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditAppointmentScreen(model: ModelFacade.getInstance())
    }
}
