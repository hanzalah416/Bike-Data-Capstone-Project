import plotly.express as px
import pandas as pd

# Data for Monday to Sunday user counts
datamember = {
    "r": [59680, 76163, 90023, 88848, 89566, 77560, 65957],
    "theta": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}

datacasual = {
    "r": [38502, 27508, 30040, 29907, 32218, 35779, 44669],
    "theta": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}

dc = pd.DataFrame(datacasual)
dm = pd.DataFrame(datamember)

figdc = px.line_polar(dc, r='r', theta='theta', line_close=True)
figdm = px.line_polar(dm, r='r', theta='theta', line_close=True)

# Display the figure
figdc.show()
figdm.show()


