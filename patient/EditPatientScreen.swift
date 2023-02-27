
import SwiftUI

struct EditPatientScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    @State var bean : Patient = Patient()
    
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
      	HStack (spacing: 20) {
      	Text("patientId:")
      	Divider()
        Picker("Patient", selection: $objectId) { 
        	ForEach(model.currentPatients) { Text($0.patientId).tag($0.patientId) }
        }.pickerStyle(.menu)
        }.frame(width: 200, height: 30).border(Color.gray)
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


HStack (spacing: 20) {
		Button(action: { 
	bean = model.getPatientByPK(val: objectId) ?? bean
		} ) { Text("Search") }
        Button(action: { 
        	self.model.editPatient(x: PatientVO(x: bean))
        } ) { Text("Edit") }
        Button(action: { self.model.cancelEditPatient() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top)
    .onAppear(perform:
            {   objectId = model.currentPatient?.patientId ?? "id" 
            	model.listPatient()
            })
    	}.navigationTitle("Edit Patient")
     }
  }
}

struct EditPatientScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditPatientScreen(model: ModelFacade.getInstance())
    }
}
