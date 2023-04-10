import tkinter as tk
import tkinter.messagebox
from utils import *


class NewRoomForm(tk.Frame):
    def __init__(self, parent):
        super().__init__(parent)
        self.parent = parent

        self.room_label = tk.Label(self, text="Room No:")
        self.room_entry = tk.Entry(self)

        # create service selection dropdown
        self.type_var = tk.StringVar(self)
        self.type_var.set("Select room type")
        self.type_label = tk.Label(self, text="Room Type:")
        self.type_menu = tk.OptionMenu(
            self, self.type_var, "Select room type", *self.get_room_type_list())

        self.room_status_var = tk.BooleanVar(self, value=True)
        self.room_status_checkbox = tk.Checkbutton(
            self, text="Room Availability", variable=self.room_status_var)

        # create submit button
        self.submit_button = tk.Button(
            self, text="Submit", command=self.submit)

        self.room_label.grid(row=0, column=0, padx=5, pady=5)
        self.room_entry.grid(row=0, column=1, padx=5, pady=5)

        self.type_label.grid(row=1, column=0, padx=5, pady=5)
        self.type_menu.grid(row=1, column=1, padx=5, pady=5)

        self.room_status_checkbox.grid(row=2, column=1, padx=5, pady=5)

        self.submit_button.grid(row=3, column=1, padx=5, pady=5)

    def get_room_type_list(self):
        return execute("get_room_type_list.sql", getInfo=True)

    def submit(self):
        # retrieve user inputs
        room_no = self.room_entry.get()
        room_type = self.type_var.get()
        room_type = room_type[2:-3]
        room_status = self.room_status_var.get()
        print(room_status)
        executeProc(room_no, room_type, room_status, procName="new_room")

        success_message = f"Room no. {room_no} of type {room_type} added successfully."
        tk.messagebox.showinfo("Success", success_message)
        self.parent.destroy()
