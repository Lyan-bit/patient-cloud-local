
import SwiftUI

struct DeletePatientScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
            HStack (spacing: 20) {
             	Text("patientId:").bold()
             	Divider()
		        Picker("Patient", selection: $objectId) { 
		        	ForEach(model.currentPatients) { Text($0.patientId).tag($0.patientId) }
		        }.pickerStyle(.menu)
		    }.frame(width: 200, height: 30).border(Color.gray)

        HStack(spacing: 20) {
            Button(action: { self.model.deletePatient(id: objectId) } ) { Text("Delete") }
			Button(action: { self.model.cancelDeletePatient() } ) { Text("Cancel") }
        }.buttonStyle(.bordered)
      }.padding(.top).onAppear(perform:
        {   objectId = model.currentPatient?.patientId ?? "patientId" 
        	model.listPatient()
        })
        }.navigationTitle("Delete Patient")
       }
    } 
}

struct DeletePatientScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeletePatientScreen(model: ModelFacade.getInstance())
    }
}

