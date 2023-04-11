import tkinter as tk
from tkinter import ttk
from utils import *
from new_staff_form import *
from edit_staff_form import *


class Staff():
    def __init__(self, frame, frame1):
        super().__init__()
        self.frame = frame
        self.frame1 = frame1
        self.create_widgets()

    def create_widgets(self):
        self.table = ttk.Treeview(self.frame, columns=(
            "staff_id", "name", "phone", "email", "position"), show="headings")
        self.table.heading("staff_id", text="Staff ID",command=lambda: treeview_sort_column(self.table, "staff_id", False))
        self.table.heading("name", text="Name",command=lambda: treeview_sort_column(self.table, "name", False))
        self.table.heading("phone", text="Phone",command=lambda: treeview_sort_column(self.table, "phone", False))
        self.table.heading("email", text="Email",command=lambda: treeview_sort_column(self.table, "email", False))
        self.table.heading("position", text="Position",command=lambda: treeview_sort_column(self.table, "position", False))
        scrollbar = ttk.Scrollbar(
            self.frame, orient="vertical", command=self.table.yview)
        self.table.configure(yscrollcommand=scrollbar.set)
        data = self.get_staff_data()
        for i in data:
            self.table.insert("", tk.END, values=i)
        self.table.pack(side=tk.TOP, fill=tk.BOTH,
                        expand=True, padx=20, pady=20)
        b1 = tk.Button(self.frame1, text='Add', width=10, command=self.add)
        b2 = tk.Button(self.frame1, text='Update',
                       width=10, command=self.update)
        b3 = tk.Button(self.frame1, text='Delete',
                       width=10, command=self.delete)
        b4 = tk.Button(self.frame1, text='Refresh',
                       width=10, command=self.refresh)
        b1.grid(row=0, column=0, padx=10)
        b2.grid(row=0, column=1, padx=10)
        b3.grid(row=0, column=2, padx=10)
        b4.grid(row=0, column=3, padx=10)

    def get_staff_data(self):
        return execute("fetch_staff_info.sql", True)

    def add(self):
        root = tk.Tk()
        root.title("Add Staff")
        form = NewStaffForm(root)
        form.pack()
        root.mainloop()

    def update(self):
        selectedItems = self.table.selection()
        if (len(selectedItems) != 1):
            label = tk.Label(
                self.frame, text="Please select a single row to update", fg="red")
            label.pack()
            return
        id = self.table.item(selectedItems[0], "values")[0]
        root = tk.Tk()
        root.title("Update Staff")
        form = UpdateStaffForm(root, id, self.table.item(
            selectedItems[0], "values")[1:])
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
            executeProc(self.table.item(item, "values")
                        [0], procName="delete_staff")
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Staff(self.frame, self.frame1)

    def refresh(self):
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Staff(self.frame, self.frame1)
