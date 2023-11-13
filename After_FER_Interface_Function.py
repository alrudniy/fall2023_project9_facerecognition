import requests

def fetch_weather_data(api_endpoint, api_key, city_name):
    """
    Makes an API call to fetch weather data for the given city.
    
    Parameters:
    api_endpoint (str): The endpoint URL of the weather service API.
    api_key (str): The API key to authenticate with the weather service.
    city_name (str): The name of the city.
    
    Returns:
    dict: A dictionary with the response from the weather service.
    """
    # Construct the full URL with the city name and API key
    url = f"{api_endpoint}?q={city_name}&appid={api_key}"
    
    try:
        # Make the API call
        response = requests.get(url)
        response.raise_for_status()  # Raises HTTPError if the HTTP request returned an unsuccessful status code
        
        # Return the JSON response if the call was successful
        return response.json()
    
    except requests.exceptions.HTTPError as http_err:
        # Handle HTTP errors
        print(f"HTTP error occurred: {http_err}")
    except Exception as err:
        # Handle other possible errors
        print(f"An error occurred: {err}")
    
    return {}

def get_weather(api_endpoint, api_key, city_name):
    """
    Fetches the current weather for a specified city and extracts relevant information.
    
    Parameters:
    api_endpoint (str): The endpoint URL of the weather service API.
    api_key (str): The API key to authenticate with the weather service.
    city_name (str): The name of the city to fetch the weather for.
    
    Returns:
    dict: A dictionary containing weather information such as temperature, humidity, and weather description.
    """
    # Fetch the weather data from the API
    weather_data = fetch_weather_data(api_endpoint, api_key, city_name)
    
    if weather_data:
        # Process the weather data if retrieval was successful
        weather_info = {
            'temperature': weather_data.get('main', {}).get('temp'),
            'humidity': weather_data.get('main', {}).get('humidity'),
            'description': weather_data.get('weather', [{}])[0].get('description')
        }
        return weather_info
    else:
        # Return a default response if data retrieval failed
        return {'error': 'Could not retrieve weather data'}

# Example usage (with dummy API endpoint and key):
api_endpoint = 'http://api.weatherapi.com/v1/current.json'
api_key = 'YOUR_API_KEY_HERE'

print(get_weather(api_endpoint, api_key, 'New York'))
