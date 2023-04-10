import tkinter as tk


class AdminHomePageScreen(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Admin Home Page")
        self.geometry("400x300")
        self.create_widgets()

    def create_widgets(self):
        # Create some sample widgets for the admin home page screen
        self.welcome_label = tk.Label(
            self, text="Welcome to the Admin Home Page!")
        self.welcome_label.pack()

        self.logout_button = tk.Button(
            self, text="Logout", command=self.logout)
        self.logout_button.pack()

    def logout(self):
        # Close the admin home page screen and show the login screen again
        self.destroy()  # close admin home screen
