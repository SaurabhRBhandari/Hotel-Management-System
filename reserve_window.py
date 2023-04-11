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
        self.table = ttk.Treeview(self.frame, columns=(
                "bill_id", "room_no", "customer_name", "check_in", "check_out"), show="headings")
        self.table.heading("bill_id", text="Bill ID", command=lambda: treeview_sort_column(self.table, "bill_id", False))
        self.table.heading("room_no", text="Room No.", command=lambda: treeview_sort_column(self.table, "room_no", False))
        self.table.heading("customer_name", text="Name", command=lambda: treeview_sort_column(self.table, "customer_name", False))
        self.table.heading("check_in", text="Check In Date", command=lambda: treeview_sort_column(self.table, "check_in", False))
        self.table.heading("check_out", text="Check Out Date", command=lambda: treeview_sort_column(self.table, "check_out", False))
        scrollbar = ttk.Scrollbar(
            self.frame, orient="vertical", command=self.table.yview)
        self.table.configure(yscrollcommand=scrollbar.set)
        data = self.get_reservation_data()
        for i in data:
            self.table.insert("", tk.END, values=i)
        self.table.pack(side=tk.TOP, fill=tk.BOTH,
                        expand=True, padx=20, pady=20)
        b1 = tk.Button(self.frame1, text='Add', width=10, command=self.add)
        b2 = tk.Button(self.frame1, text='Delete',
                    width=10, command=self.delete)
        b3 = tk.Button(self.frame1, text='Refresh',
                    width=10, command=self.refresh)
        b1.grid(row=0, column=0, padx=10)
        b2.grid(row=0, column=1, padx=10)
        b3.grid(row=0, column=2, padx=10)

    def add(self):
        root = tk.Tk()
        root.title("Select Room(s)")
        form = RoomSelectionForm(root)
        form.pack()
        root.mainloop()

    def delete(self):
        selectedItems = self.table.selection()
        if (len(selectedItems) == 0):
            label = tk.Label(
                self.frame, text="Please select a row to delete", fg="red")
            label.pack()
            return
        for item in selectedItems:
            print(self.table.item(item, "values")[0],self.table.item(item,"values")[1])
            executeProc(int(self.table.item(item, "values")
                        [0]),int(self.table.item(item,"values")[1]),procName="delete_reservation")
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Reserve(self.frame, self.frame1)

    def refresh(self):
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Reserve(self.frame, self.frame1)
    
    def get_reservation_data(self):
        return execute("fetch_reservation_info.sql", True)
