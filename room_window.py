import tkinter as tk
from tkinter import ttk
from utils import *
from new_room_form import *
from allot_staff_form import *
from tkcalendar import DateEntry, Calendar


class Room():
    def __init__(self, frame, frame1):
        super().__init__()
        self.frame = frame
        self.frame1 = frame1
        self.create_widgets()

    def create_widgets(self):
        self.table = ttk.Treeview(self.frame, columns=(
            "room_no", "type", "status", "staff", "staying"), show="headings")
        self.table.heading("room_no", text="Room no.")
        self.table.heading("type", text="Room Type")
        self.table.heading("status", text="Status")
        self.table.heading("staff", text="Staff")
        self.table.heading("staying", text="Guest")
        scrollbar = ttk.Scrollbar(
            self.frame, orient="vertical", command=self.table.yview)
        self.table.configure(yscrollcommand=scrollbar.set)
        data = self.get_room_data()
        for i in data:
            self.table.insert("", tk.END, values=i)
        self.table.pack(side=tk.TOP, fill=tk.BOTH,
                        expand=True, padx=20, pady=20)
        b1 = tk.Button(self.frame1, text='Add', width=10, command=self.add)
        b2 = tk.Button(self.frame1, text='Allot Staff',
                       width=10, command=self.allot)
        b3 = tk.Button(self.frame1, text='Toggle Status',
                       width=10, command=self.alter)
        b4 = tk.Button(self.frame1, text='Refresh',
                       width=10, command=self.refresh)
        b1.grid(row=0, column=0, padx=10)
        b2.grid(row=0, column=1, padx=10)
        b3.grid(row=0, column=2, padx=10)
        b4.grid(row=0, column=3, padx=10)

    def get_room_data(self):
        return execute("fetch_room_info.sql", True)

    def add(self):
        root = tk.Tk()
        root.title("Add Room")
        form = NewRoomForm(root)
        form.pack()
        root.mainloop()

    def allot(self):
        selectedItems = self.table.selection()
        if (len(selectedItems) == 0):
            label = tk.Label(
                self.frame, text="Please select room(s) to allot staff to", fg="red")
            label.pack()
            return
        root = tk.Tk()
        root.title("Select Staff")
        popup = StaffIDPopup(root)
        root.wait_window(root)
        staffid = popup.staff_id
        for item in selectedItems:
            executeProc(staffid, self.table.item(
                item, "values")[0], procName="set_staff")
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Room(self.frame, self.frame1)

    def alter(self):
        selectedItems = self.table.selection()
        if (len(selectedItems) == 0):
            label = tk.Label(
                self.frame, text="Please select room(s) to toggle", fg="red")
            label.pack()
            return
        for item in selectedItems:
            executeProc(self.table.item(item, "values")
                        [0], procName="toggle_status")
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Room(self.frame, self.frame1)

    def refresh(self):
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Room(self.frame, self.frame1)
