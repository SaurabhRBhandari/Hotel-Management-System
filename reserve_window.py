import tkinter as tk
from tkinter import ttk
from utils import *
from room_selection_form import *


class Reserve():
    def __init__(self, frame, frame1):
        super().__init__()
        self.frame = frame
        self.frame1 = frame1
        self.create_widgets()

    def create_widgets(self):
        welcome_label = tk.Label(
            self.frame, text="Welcome To Hotel Management System!", font=("Arial", 24), fg="blue")

        welcome_label.pack(padx=250, pady=50)
        b1 = tk.Button(self.frame1, text='Make a Booking',
                       width=10, command=self.add)
        b1.pack(side='left', padx=40, pady=40)

    def add(self):
        root = tk.Tk()
        root.title("Add Staff")
        form = RoomSelectionForm(root)
        form.pack()
        root.mainloop()
