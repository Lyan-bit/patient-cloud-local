              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : ModelFacade
	                                       
	var body: some View {
		TabView {
            CreatePatientScreen (model: model).tabItem { 
                        Image(systemName: "1.square.fill")
	                    Text("+Patient")} 
            ListPatientScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("ListPatient")} 
            EditPatientScreen (model: model).tabItem { 
                        Image(systemName: "3.square.fill")
	                    Text("EditPatient")} 
            DeletePatientScreen (model: model).tabItem { 
                        Image(systemName: "4.square.fill")
	                    Text("-Patient")} 
            CreateAppointmentScreen (model: model).tabItem { 
                        Image(systemName: "5.square.fill")
	                    Text("+Appointment")} 
            ListAppointmentScreen (model: model).tabItem { 
                        Image(systemName: "6.square.fill")
	                    Text("ListAppointment")} 
            EditAppointmentScreen (model: model).tabItem { 
                        Image(systemName: "7.square.fill")
	                    Text("EditAppointment")} 
            DeleteAppointmentScreen (model: model).tabItem { 
                        Image(systemName: "8.square.fill")
	                    Text("-Appointment")} 
            AddPatientattendsAppointmentScreen (model: model).tabItem { 
                        Image(systemName: "9.square.fill")
	                    Text("AddPatientattendsAppointment")} 
            RemovePatientattendsAppointmentScreen (model: model).tabItem { 
                        Image(systemName: "10.square.fill")
	                    Text("RemovePatientattendsAppointment")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ModelFacade.getInstance())
    }
}

