from tkinter import *
import mysql.connector as mysql
from log_in_page import LoginScreen
from utils import *

print("Database connected successfully!")

# starting the GUI
login_screen = LoginScreen()
login_screen.mainloop()
