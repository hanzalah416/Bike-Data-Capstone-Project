import plotly.express as px
import pandas as pd

# Data for member user counts by month
datamember = {
    "r": [49702, 51521, 51003, 48776, 39814, 43197, 43064, 40937, 43886, 43541, 44563, 47793],
    "theta": ["Dec 2022", "Jan 2023", "Feb 2023", "Mar 2023", "Apr 2023", "May 2023", "Jun 2023", "Jul 2023", "Aug 2023", "Sep 2023", "Oct 2023", "Nov 2023"]
}

# Data for casual user counts by month
datacasual = {
    "r": [15833, 14014, 14532, 16759, 25721, 22338, 22471, 24598, 21649, 21994, 20972, 17742],
    "theta": ["Dec 2022", "Jan 2023", "Feb 2023", "Mar 2023", "Apr 2023", "May 2023", "Jun 2023", "Jul 2023", "Aug 2023", "Sep 2023", "Oct 2023", "Nov 2023"]
}

dc = pd.DataFrame(datacasual)
dm = pd.DataFrame(datamember)

figdc = px.line_polar(dc, r='r', theta='theta', line_close=True)
figdm = px.line_polar(dm, r='r', theta='theta', line_close=True)

# Display the figures
#figdc.show()
figdm.show()
