//
//  ContentView.swift
//  Day12_Assignment
//
//  Created by Rayaheen Mseri on 17/09/1446 AH.
//
import SwiftUI

// ContentView is the main view of the app.
struct ContentView: View {
    // State object to manage the ViewModel, which fetches and holds weather data.
    @StateObject private var viewModel = ViewModel()
    
    // State variable for holding the city name entered by the user.
    @State private var cityName: String = "London"
    
    // State to ensure the weather is fetched only once when the view first appears.
    @State private var hasLoaded: Bool = false
    
    var body: some View {
        ZStack{
            // A background image that fills the screen and ignores safe area boundaries.
            Image("pic1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            
            // Shows loading indicator when the weather data is being fetched.
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())  // Circular progress style
                    .scaleEffect(2)  // Enlarges the progress indicator
            } else {
                // Main content displayed after data has loaded
                VStack{
                    // TextField for the user to enter a city name.
                    TextField("Enter City Name" , text: $cityName)
                        .background{
                            // Capsule-shaped background with blue border around the TextField.
                            Capsule()
                                .fill(.background)
                                .stroke(.blue, lineWidth: 1)
                                .frame(width: 300, height: 50)
                        }
                        .padding()
                        .frame(width: 300, height: 100)
                    
                    // Displays an error message if the weather data fetching fails.
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        // Displays the weather data if no error occurred.
                        HStack{
                            // Displays the city name in large blue font.
                            Text(viewModel.cityName)
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.blue)
                            
                            // Displays the weather icon.
                            Text(viewModel.icon ?? "")
                        }
                        // Displays the temperature in bold.
                        Text(viewModel.temperature)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.blue)
                        
                        // Displays the weather description.
                        Text(viewModel.weatherDescription)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.blue)
                    }
                    
                    // Spacer to push content upwards.
                    Spacer()
                    
                    // Button to fetch weather data when clicked.
                    Button("Fetch Weather"){
                        viewModel.fetchWeather(for: cityName)
                    }
                    .padding()
                    .background{
                        // Button background styled as a capsule.
                        Capsule()
                            .fill(.blue)
                    }
                    .foregroundColor(.white)  // White text for the button
                    .fontWeight(.bold)
                }
                .padding()  // Adds padding around the VStack content
                
                // Ensures that the weather data is fetched only once when the view appears.
                .onAppear{
                    if !hasLoaded {
                        viewModel.fetchWeather(for: cityName)
                        hasLoaded = true
                    }
                }
            }
        }
    }
}

// Previews the ContentView for use in SwiftUI previews.
#Preview {
    ContentView()
}
