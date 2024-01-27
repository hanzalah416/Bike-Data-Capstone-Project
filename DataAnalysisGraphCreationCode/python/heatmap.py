
import pandas as pd
import folium
from folium.plugins import HeatMap


file_path = '../../Data/Cleaned:Organized Data/12monthsdata2023.csv'
# Load your CSV file
data = pd.read_csv(file_path)


# Remove rows with NaN values in start_lat or start_lng
data = data.dropna(subset=['start_lat', 'start_lng'])

# Split the dataset into two based on rider type
member_data = data[data['member_casual'] == 'member']
casual_data = data[data['member_casual'] == 'casual']

# Extract latitude and longitude pairs for each dataset
member_lat_long_pairs = member_data[['start_lat', 'start_lng']].values
casual_lat_long_pairs = casual_data[['start_lat', 'start_lng']].values

# Define the center of your maps
center_latitude = 41.90157166972085
center_longitude = -87.64722938835763

# Function to create a heatmap
def create_heatmap(data, file_name):
    map = folium.Map(location=[center_latitude, center_longitude], zoom_start=13)
    HeatMap(data).add_to(map)
    map.save(file_name)

# Create and save heatmaps
create_heatmap(member_lat_long_pairs, 'member_heatmap.html')
create_heatmap(casual_lat_long_pairs, 'casual_heatmap.html')
