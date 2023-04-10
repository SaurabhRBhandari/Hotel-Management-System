from tkinter import *
import mysql.connector as mysql
from log_in import LoginScreen
from utils import *

execute("init_db.sql")
execute("book_room.sql")
execute("procedures.sql")
print("Database connected successfully!")

# starting the GUI
login_screen = LoginScreen()
login_screen.mainloop()