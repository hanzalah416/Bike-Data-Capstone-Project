import matplotlib.pyplot as plt
import numpy as np

# Replace these values with your raw counts
member_classic_count = 300533  # Replace with actual count
member_electric_count = 247264  # Replace with actual count
casual_classic_count = 109688  # Replace with actual count
casual_electric_count = 117363  # Replace with actual count
		
# Calculating percentages
total_member = member_classic_count + member_electric_count
total_casual = casual_classic_count + casual_electric_count

member_classic_percent = (member_classic_count / total_member) * 100
member_electric_percent = (member_electric_count / total_member) * 100
casual_classic_percent = (casual_classic_count / total_casual) * 100
casual_electric_percent = (casual_electric_count / total_casual) * 100


print(f"Member - Classic Bike: {member_classic_percent:.2f}%")
print(f"Member - Electric Bike: {member_electric_percent:.2f}%")
print(f"Casual - Classic Bike: {casual_classic_percent:.2f}%")
print(f"Casual - Electric Bike: {casual_electric_percent:.2f}%")

# Categories
categories = ['Classic', 'Electric']

# Values
member_values = [member_classic_percent, member_electric_percent]
casual_values = [casual_classic_percent, casual_electric_percent]

# X axis locations for the groups
barWidth = 0.35
r1 = np.arange(len(categories))
r2 = [x + barWidth for x in r1]

# Create the bar chart
plt.bar(r1, member_values, color='b', width=barWidth, edgecolor='grey', label='Member')
plt.bar(r2, casual_values, color='r', width=barWidth, edgecolor='grey', label='Casual')

# Add labels
plt.xlabel('Bike Type', fontweight='bold')
plt.xticks([r + barWidth for r in range(len(categories))], categories)
plt.ylabel('Percentage (%)', fontweight='bold')
plt.title('Percentage of Bike Usage by Type and User Category')

# Create legend & Show graphic
plt.legend()
plt.show()
