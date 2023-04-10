import tkinter as tk
import tkinter.messagebox
from utils import *


class NewOrderForm(tk.Frame):
    def __init__(self, parent):
        super().__init__(parent)
        self.parent = parent

        # create room selection dropdown
        self.room_label = tk.Label(self, text="Room No:")
        self.room_entry = tk.Entry(self)

        # create service selection dropdown
        self.service_var = tk.StringVar(self)
        self.service_var.set("Select a service")
        self.service_label = tk.Label(self, text="Service:")
        self.service_menu = tk.OptionMenu(
            self, self.service_var, "Select a service", *self.get_service_list())

        # create quantity input field
        self.quantity_var = tk.StringVar(self)
        self.quantity_var.set("1")
        self.quantity_label = tk.Label(self, text="Quantity:")
        self.quantity_entry = tk.Entry(self, textvariable=self.quantity_var)

        # create submit button
        self.submit_button = tk.Button(
            self, text="Submit", command=self.submit_order)

        self.room_label.grid(row=0, column=0, padx=5, pady=5)
        self.room_entry.grid(row=0, column=1, padx=5, pady=5)

        self.service_label.grid(row=1, column=0, padx=5, pady=5)
        self.service_menu.grid(row=1, column=1, padx=5, pady=5)

        self.quantity_label.grid(row=2, column=0, padx=5, pady=5)
        self.quantity_entry.grid(row=2, column=1, padx=5, pady=5)

        self.submit_button.grid(row=3, column=1, padx=5, pady=5)

    # def get_room_list(self):
    #     return execute("get_room_list.sql",getInfo=True)

    def get_service_list(self):
        return execute("get_service_list.sql", getInfo=True)

    def submit_order(self):
        # retrieve user inputs
        room = self.room_entry.get()
        service = self.service_var.get()
        quantity = int(self.quantity_var.get())
        service = service[2:-3]
        executeProc(room, service, quantity, procName="new_order")

        # print success message
        success_message = f"Order placed for {quantity} {service}(s) in room {room}"
        tk.messagebox.showinfo("Success", success_message)
        self.parent.destroy()
