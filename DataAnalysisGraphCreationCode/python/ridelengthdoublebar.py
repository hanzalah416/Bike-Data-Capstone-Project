import matplotlib.pyplot as plt
import numpy as np

# Member values (convert meters to kilometers for ride length)
member_values = [
    #1979.2116869764554 / 1000,  # Average Ride Length in km
    11.890369972818398,         # Average Ride Length in minutes
    8,                          # Median Ride Length in minutes
    5                           # Mode Ride Length in minutes
]

# Casual values
casual_values = [
    #2005.1486392568002 / 1000,  # Average Ride Length in km
    27.468923783541403,         # Average Ride Length in minutes
    11,                         # Median Ride Length in minutes
    6                           # Mode Ride Length in minutes
]

# Categories
categories = ['Avg RL (min)', 'Median RL (min)', 'Mode RL (min)']


# Set the figure size for the plot
plt.figure(figsize=(12, 6))  # Width, Height in inches

# X axis locations for the groups
barWidth = 0.35
r1 = np.arange(len(categories))
r2 = [x + barWidth for x in r1]

# Create the bar chart
plt.bar(r1, member_values, color='b', width=barWidth, edgecolor='grey', label='Member')
plt.bar(r2, casual_values, color='r', width=barWidth, edgecolor='grey', label='Casual')

# Add labels
plt.xlabel('Ride Length Categories', fontweight='bold')

# Adjust the position of the x-ticks to be in the middle of the two bars
plt.xticks([r + barWidth / 2 for r in range(len(categories))], categories)

plt.ylabel('Values', fontweight='bold')
plt.title('Comparison of Ride Length Metrics Between Members and Casual Riders')

# Create legend & Show graphic
plt.legend()
plt.show()