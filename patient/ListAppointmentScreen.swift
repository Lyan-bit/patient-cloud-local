
import SwiftUI

struct ListAppointmentScreen: View {
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

     var body: some View
     { List(model.currentAppointments){ instance in 
     	ListAppointmentRowScreen(instance: instance) }
       .onAppear(perform: { model.listAppointment() })
     }
    
}

struct ListAppointmentScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListAppointmentScreen(model: ModelFacade.getInstance())
    }
}

