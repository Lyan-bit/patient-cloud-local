
import SwiftUI

struct ListPatientRowScreen: View {
    
    var instance : PatientVO
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

      var body: some View { 
      	ScrollView {
    HStack  {
          Text(String(instance.patientId)).bold()
          Text(String(instance.name))
          Text(String(instance.appointmentId))
    }.onAppear()
          { model.setSelectedPatient(x: instance) 
          }
        }
      }
    }

    struct ListPatientRowScreen_Previews: PreviewProvider {
      static var previews: some View {
        ListPatientRowScreen(instance: PatientVO(x: PatientAllInstances[0]))
      }
    }

