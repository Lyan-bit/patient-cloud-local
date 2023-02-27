
import SwiftUI

struct ListAppointmentRowScreen: View {
    
    var instance : AppointmentVO
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

      var body: some View { 
      	ScrollView {
    HStack  {
          Text(String(instance.appointmentId)).bold()
          Text(String(instance.code))
    }.onAppear()
          { model.setSelectedAppointment(x: instance) 
          }
        }
      }
    }

    struct ListAppointmentRowScreen_Previews: PreviewProvider {
      static var previews: some View {
        ListAppointmentRowScreen(instance: AppointmentVO(x: AppointmentAllInstances[0]))
      }
    }

