//
//  WeatherViewModel.swift
//  Day12_Assignment
//
//  Created by Rayaheen Mseri on 17/09/1446 AH.
//
import SwiftUI

// ViewModel is the class responsible for fetching and managing weather data.
extension ContentView {
    
    class ViewModel: ObservableObject {
        
        // Published properties to hold weather data and UI state.
        @Published var cityName: String = "" // City name to be displayed.
        @Published var weatherDescription: String = "" // Weather description (e.g., "Sunny").
        @Published var temperature: String = "" // Temperature in Celsius.
        @Published var icon: String? = nil // Weather icon (optional).
        @Published var errorMessage: String? = nil // Error message (optional).
        @Published var isLoading: Bool = false // State to indicate if data is being fetched.

        // Function to fetch weather data for a given city.
        func fetchWeather(for city: String) {
            // URL for the OpenWeather API with the city name, temperature in Celsius, and the API key.
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=dd8b3fe3b9e0cfb0464bf70d3bacc48a&units=metric"
            
            // Ensure the URL is valid.
            guard let url = URL(string: urlString) else {
                // If invalid, update the UI with an error message on the main thread.
                DispatchQueue.main.async {
                    print("Invalid URL")
                }
                return
            }
            
            // Set the loading state to true to indicate that data is being fetched.
            self.isLoading = true
            
            // Start an asynchronous data task to fetch the weather data.
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                // Set loading to false once the network request is completed.
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
                // Handle errors in case of network issues.
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = " Network Error:  \(error.localizedDescription)"
                    }
                    return
                }
                
                // Check if the response is valid (HTTP status code).
                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Invalid response from server"
                    }
                    return
                }
                
                // Print the status code to help with debugging.
                print(httpResponse.statusCode)
                
                // Ensure the data is not nil.
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.errorMessage = "No Data Returned"
                    }
                    return
                }
                
                // Attempt to decode the JSON data into the WeatherModel object.
                do {
                    // Decode the response data into the WeatherModel struct.
                    let decodedResponse = try JSONDecoder().decode(WeatherModel.self, from: data)
                    
                    // Once the data is successfully decoded, update the UI on the main thread.
                    DispatchQueue.main.async {
                        // Assign the decoded values to the Published properties.
                        self.weatherDescription = decodedResponse.weather.first?.description ?? ""
                        self.cityName = decodedResponse.name
                        self.temperature = "\(decodedResponse.main.temp)°C"
                        self.icon = decodedResponse.weather.first?.icon ?? ""
                        self.errorMessage = nil // Clear any previous error message.
                    }
                } catch {
                    // If decoding fails, show an error message.
                    DispatchQueue.main.async {
                        self.errorMessage = "Error parsing JSON: \(error.localizedDescription)"
                    }
                }
                
            }.resume() // Start the data task.
        }
        
    }
}
