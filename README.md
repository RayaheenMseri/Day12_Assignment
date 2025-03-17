
# Weather App

A simple SwiftUI application that fetches the current weather data for a city using the OpenWeather API. The app makes an API call, parses the JSON response, and displays the weather data (such as temperature, description, and icon). It also provides a refresh button to get the latest weather information.

## Features

- Fetches current weather data from OpenWeather API.
- Displays the city name, temperature, weather description, and an icon.
- Handles errors gracefully (e.g., network errors, invalid city names).
- Provides a refresh button to get the latest weather information.

## Technologies Used

- SwiftUI
- URLSession for API calls
- Codable for parsing JSON
- Combine for state management

## Getting Started

1. Clone this repository to your local machine:
   
   ```bash
   git clone https://github.com/yourusername/weather-app.git
   ```

2. Open the project in Xcode.

3. Obtain an API key from OpenWeather:
   - Visit [OpenWeather](https://openweathermap.org/api).
   - Sign up and get an API key.
   
4. Replace the placeholder `YOUR_API_KEY_HERE` with your actual API key in the ViewModel.

5. Build and run the app on your simulator or device.

## How It Works

### 1. **API Call**  
The app makes an HTTP request to the OpenWeather API using `URLSession`. The city name entered by the user is passed as a query parameter. Upon a successful response, the app decodes the JSON data using the `Codable` protocol.

### 2. **Displaying Data**  
The fetched data includes:
- City name
- Current temperature
- Weather description
- Weather icon

The data is displayed on the main screen in a user-friendly format.

### 3. **Error Handling**  
The app handles errors like:
- Invalid city names
- Network errors
- Data parsing errors

### 4. **Refresh Button**  
A refresh button is provided to fetch the latest weather data for the city.
