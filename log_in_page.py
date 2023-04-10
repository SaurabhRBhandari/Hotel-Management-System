import tkinter as tk
from user_home_page import HomePageScreen
from admin_home_screen_page import AdminHomePageScreen


class LoginScreen(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Login Screen")
        self.geometry("400x300")
        self.create_widgets()

    def create_widgets(self):
        # Create the login label and entry fields
        self.username_label = tk.Label(self.master, text="Username:")
        self.username_label.pack(pady=10)
        self.username_entry = tk.Entry(self.master)
        self.username_entry.pack()

        self.password_label = tk.Label(self.master, text="Password:")
        self.password_label.pack(pady=10)
        self.password_entry = tk.Entry(self.master, show="*")
        self.password_entry.pack()

        # Create the login button
        self.login_button = tk.Button(
            self.master, text="Login", command=self.login)
        self.login_button.pack(pady=15)

    def login(self):
        # Check the username and password fields
        username = self.username_entry.get()
        password = self.password_entry.get()

        if username == "user" and password == "password":
            self.destroy()  # close login screen
            home_screen = HomePageScreen()  # create new home screen instance
            home_screen.mainloop()  # start main loop
        elif username == "admin" and password == "password":
            self.destroy()  # close login screen
            admin_screen = AdminHomePageScreen()  # create new admin screen instance
            admin_screen.mainloop()  # start main loop
        else:
            label = tk.Label(
                self.master, text="Invalid username or password", fg="red")
            label.pack()
