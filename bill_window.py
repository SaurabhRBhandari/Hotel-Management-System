import tkinter as tk
from tkinter import ttk
from utils import *
from new_guest_form import *
from edit_guest_form import *
import tkinter.messagebox as messagebox

class Bill():
    def __init__(self, frame, frame1):
        super().__init__()
        self.frame = frame
        self.frame1 = frame1
        self.create_widgets()

    def create_widgets(self):
        self.table = ttk.Treeview(self.frame, columns=(
            "bill_id", "cust_name", "base_charge", "service_charge"), show="headings")
        self.table.heading("bill_id", text="Bill ID", command=lambda: treeview_sort_column(self.table, "bill_id", False))
        self.table.heading("cust_name", text="Name", command=lambda: treeview_sort_column(self.table, "cust_name", False))
        self.table.heading("base_charge", text="Base Charge", command=lambda: treeview_sort_column(self.table, "base_charge", False))
        self.table.heading("service_charge", text="Service Charge", command=lambda: treeview_sort_column(self.table, "service_charge", False))
        scrollbar = ttk.Scrollbar(
            self.frame, orient="vertical", command=self.table.yview)
        self.table.configure(yscrollcommand=scrollbar.set)
        data = self.get_guest_data()
        for i in data:
            self.table.insert("", tk.END, values=i)
        self.table.pack(side=tk.TOP, fill=tk.BOTH,
                        expand=True, padx=150, pady=20)
        b1 = tk.Button(self.frame1, text='Generate Bill', width=10, command=self.generate)
        b2 = tk.Button(self.frame1, text='Refresh',
                       width=10, command=self.refresh)
        b1.grid(row=0, column=0, padx=10)
        b2.grid(row=0, column=1, padx=10)

    def get_guest_data(self):
        return execute("fetch_bill_info.sql", True)

    def generate(self):
        selectedItems = self.table.selection()
        if (len(selectedItems) != 1):
            label = tk.Label(
                self.frame, text="Please select a single row to generate bill for", fg="red")
            label.pack()
            return
        bill_no=int(self.table.item(selectedItems[0], "values")[0])
        data=executeProc(bill_no, procName="generate_bill", getInfo=True)[0][0]
        BillWindow(*data)
        

    def refresh(self):
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Bill(self.frame, self.frame1)

class BillWindow(tk.Tk):
    def __init__(self, name, email, base_cost, service_cost, checkin_date, checkout_date, num_rooms):
        super().__init__()

        self.title("Bill")

        # Define labels and display values
        name_label = tk.Label(self, text="Name: ")
        name_value = tk.Label(self, text=name)
        email_label = tk.Label(self, text="Email: ")
        email_value = tk.Label(self, text=email)
        base_cost_label = tk.Label(self, text="Base Cost: ")
        base_cost_value = tk.Label(self, text=f"${base_cost:.2f}")
        service_cost_label = tk.Label(self, text="Service Cost: ")
        service_cost_value = tk.Label(self, text=f"${service_cost:.2f}")
        checkin_date_label = tk.Label(self, text="Check-in Date: ")
        checkin_date_value = tk.Label(self, text=str(checkin_date))
        checkout_date_label = tk.Label(self, text="Check-out Date: ")
        checkout_date_value = tk.Label(self, text=str(checkout_date))
        num_rooms_label = tk.Label(self, text="Number of Rooms: ")
        num_rooms_value = tk.Label(self, text=num_rooms)

        # Set label and value fonts and colors
        label_font = ("Arial", 12, "bold")
        value_font = ("Arial", 12)
        label_color = "#333"
        value_color = "#555"
        name_label.config(font=label_font, fg=label_color)
        name_value.config(font=value_font, fg=value_color)
        email_label.config(font=label_font, fg=label_color)
        email_value.config(font=value_font, fg=value_color)
        base_cost_label.config(font=label_font, fg=label_color)
        base_cost_value.config(font=value_font, fg=value_color)
        service_cost_label.config(font=label_font, fg=label_color)
        service_cost_value.config(font=value_font, fg=value_color)
        checkin_date_label.config(font=label_font, fg=label_color)
        checkin_date_value.config(font=value_font, fg=value_color)
        checkout_date_label.config(font=label_font, fg=label_color)
        checkout_date_value.config(font=value_font, fg=value_color)
        num_rooms_label.config(font=label_font, fg=label_color)
        num_rooms_value.config(font=value_font, fg=value_color)

        # Add padding between labels and values
        padx = 10
        pady = 5
        name_label.grid(row=0, column=0, sticky="w", padx=padx, pady=pady)
        name_value.grid(row=0, column=1, sticky="e", padx=padx, pady=pady)
        email_label.grid(row=1, column=0, sticky="w", padx=padx, pady=pady)
        email_value.grid(row=1, column=1, sticky="e", padx=padx, pady=pady)
        base_cost_label.grid(row=2, column=0, sticky="w", padx=padx, pady=pady)
        base_cost_value.grid(row=2, column=1, sticky="e", padx=padx, pady=pady)
        service_cost_label.grid(row=3, column=0, sticky="w", padx=padx, pady=pady)
        service_cost_value.grid(row=3, column=1, sticky="e", padx=padx, pady=pady)
        checkin_date_label.grid(row=4, column=0, sticky="w", padx=padx, pady=pady)
        checkin_date_value.grid(row=4, column=1, sticky="e", padx=padx, pady=pady)
        checkout_date_label.grid(row=5, column=0, sticky="w", padx=padx, pady=pady)
        checkout_date_value.grid(row=5, column=1, sticky="e", padx=padx, pady=pady)
        num_rooms_label.grid(row=6, column=0, sticky="w", padx=padx, pady=pady)
        num_rooms_value.grid(row=6, column=1, sticky="e", padx=padx, pady=pady)

