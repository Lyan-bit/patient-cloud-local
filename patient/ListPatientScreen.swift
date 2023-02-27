
import SwiftUI

struct ListPatientScreen: View {
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

     var body: some View
     { List(model.currentPatients){ instance in 
     	ListPatientRowScreen(instance: instance) }
       .onAppear(perform: { model.listPatient() })
     }
    
}

struct ListPatientScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListPatientScreen(model: ModelFacade.getInstance())
    }
}

