import tkinter as tk
from utils import *


class NewStaffForm(tk.Frame):
    def __init__(self, parent):
        super().__init__(parent)
        self.parent = parent
        # create labels and entry fields for each input
        self.name_label = tk.Label(self, text="Name:")
        self.name_entry = tk.Entry(self)

        self.phone_label = tk.Label(self, text="Phone:")
        self.phone_entry = tk.Entry(self)

        self.email_label = tk.Label(self, text="Email:")
        self.email_entry = tk.Entry(self)

        self.address_label = tk.Label(self, text="Address:")
        self.address_entry = tk.Entry(self)

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

        self.address_label.grid(row=3, column=0, padx=5, pady=5)
        self.address_entry.grid(row=3, column=1, padx=5, pady=5)

        self.position_label.grid(row=4, column=0, padx=5, pady=5)
        self.position_entry.grid(row=4, column=1, padx=5, pady=5)

        self.submit_button.grid(row=5, column=1, padx=5, pady=5)

    def submit_form(self):
        # retrieve input values from form fields
        name = self.name_entry.get()
        phone = self.phone_entry.get()
        email = self.email_entry.get()
        address = self.address_entry.get()
        position = self.position_entry.get()
        executeProc(name, phone, email, address,
                    position, procName="new_staff")
        self.parent.destroy()
