import tkinter as tk
from utils import *
import matplotlib.pyplot as plt
class AdminHomePageScreen(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Admin Home Page")
        self.geometry("600x700")
        self.create_widgets()

    def create_widgets(self):
        text_field = tk.Label(self, width=50,font=("Arial", 16))

        canvas = tk.Canvas(self, width=600, height=600)
        canvas.grid(row=0,columnspan=3)
        rooms=execute('get_occupied_rooms.sql',getInfo=True)
        x = 50
        y = 50
        for room in rooms:
            room_number = room[0]
            if room[1] == 2:  # room is vacant
                fill_color = "green"
            elif room[1] == 1:  # room is occupied
                fill_color = "gray"
            else :
                fill_color = "red"
            canvas.create_rectangle(x, y, x+50, y+50, fill=fill_color, outline="black", tag=("room", room[2]))
            canvas.create_text(x+25, y+25, text=str(room_number))
            x += 60
            if x > 450:
                x = 50
                y += 60

        def on_rectangle_click(event):
            data = event.widget.gettags("current")[1]
            if data == "None":
                data=0
            text_field.config(text=f"This Room is booked for {data} more days.")
            

        canvas.tag_bind("room", "<Enter>", on_rectangle_click)
        
        text_field.grid(row=1,column=0,pady=20,columnspan=3)
        
        pie_button = tk.Button(self, text="Revenue", command=self.generate_pie_chart)
        pie_button.grid(row=2, column=0,sticky="e")
        
        refresh_button = tk.Button(self, text="Refresh", command=self.refresh)
        refresh_button.grid(row=2, column=1)
        
        logout_button = tk.Button(self, text="Logout", command=self.logout)
        logout_button.grid(row=2, column=2,sticky="w")
        
    
     
    
    def generate_pie_chart(self):
        data = execute('get_revenue.sql', getInfo=True)
        room_types = [row[0] for row in data]
        revenues = [row[1] for row in data]

        fig, ax = plt.subplots(figsize=(8,3))
        ax.pie(revenues, labels=None,  autopct=lambda p: f'{p:.1f}%' if p >= 3 else '', startangle=90)
        ax.axis('equal')
        
        # Add a legend to show room types and their total revenue
        legend_labels = [f'{room_types[i]} (${revenues[i]})' for i in range(len(room_types))]
        ax.legend(legend_labels, loc='upper right', bbox_to_anchor=(1.1, 1))
        
        plt.show()
        
    def refresh(self):
        self.destroy()
        AdminHomePageScreen().mainloop()

    def logout(self):
        # Close the admin home page screen and show the login screen again
        self.destroy()  # close admin home screen

if __name__=="__main__":
    app = AdminHomePageScreen()
    app.mainloop()