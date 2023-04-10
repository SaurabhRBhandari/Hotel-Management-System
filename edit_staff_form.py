import tkinter as tk
from utils import *


class UpdateStaffForm(tk.Frame):
    def __init__(self, parent, id, data):
        super().__init__(parent)
        self.data = data
        self.parent = parent
        self.staff_id = id
        # create labels and entry fields for each input
        self.name_label = tk.Label(self, text="Name:")
        self.name_entry = tk.Entry(self)

        self.phone_label = tk.Label(self, text="Phone:")
        self.phone_entry = tk.Entry(self)

        self.email_label = tk.Label(self, text="Email:")
        self.email_entry = tk.Entry(self)

        self.position_label = tk.Label(self, text="Position:")
        self.position_entry = tk.Entry(self)

        # create a submit button to add the new customer to the database
        self.submit_button = tk.Button(
            self, text="Submit", command=self.submit_form)

        # position the form elements using grid layout
        self.name_label.grid(row=0, column=0, padx=5, pady=5)
        self.name_entry.grid(row=0, column=1, padx=5, pady=5)

        self.phone_label.grid(row=1, column=0, padx=5, pady=5)
        self.phone_entry.grid(row=1, column=1, padx=5, pady=5)

        self.email_label.grid(row=2, column=0, padx=5, pady=5)
        self.email_entry.grid(row=2, column=1, padx=5, pady=5)

        self.position_label.grid(row=3, column=0, padx=5, pady=5)
        self.position_entry.grid(row=3, column=1, padx=5, pady=5)

        self.submit_button.grid(row=4, column=1, padx=5, pady=5)

        self.populateForm()

    def populateForm(self):
        self.name_entry.insert(0, self.data[0])
        self.phone_entry.insert(0, self.data[1])
        self.email_entry.insert(0, self.data[2])
        self.position_entry.insert(0, self.data[3])

    def submit_form(self):
        # retrieve input values from form fields
        name = self.name_entry.get()
        phone = self.phone_entry.get()
        email = self.email_entry.get()
        position = self.position_entry.get()
        executeProc(self.staff_id, name, phone, email,
                    position, procName="update_staff")
        self.parent.destroy()
