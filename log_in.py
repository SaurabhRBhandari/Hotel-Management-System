import tkinter as tk
from home_screen import HomePageScreen
class LoginScreen(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Login Screen")
        self.create_widgets()

    def create_widgets(self):
        # Create the login label and entry fields
        self.username_label = tk.Label(self.master, text="Username:")
        self.username_label.pack()
        self.username_entry = tk.Entry(self.master)
        self.username_entry.pack()

        self.password_label = tk.Label(self.master, text="Password:")
        self.password_label.pack()
        self.password_entry = tk.Entry(self.master, show="*")
        self.password_entry.pack()

        # Create the login button
        self.login_button = tk.Button(self.master, text="Login", command=self.login)
        self.login_button.pack()

    def login(self):
        # Check the username and password fields
        username = self.username_entry.get()
        password = self.password_entry.get()

        if username == "user" and password == "password":
            self.destroy() # close login screen
            home_screen = HomePageScreen() # create new home screen instance
            home_screen.mainloop() # start main loop
        else:
            # Login failed
            print("Login failed. Please try again.")

login_screen = LoginScreen()
login_screen.mainloop()
