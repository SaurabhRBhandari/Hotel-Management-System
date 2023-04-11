import tkinter as tk
from tkinter import ttk
from utils import *
from tkcalendar import Calendar, DateEntry
import tkinter.messagebox


class RoomSelectionForm(tk.Frame):
    def __init__(self, master=None):
        super().__init__(master)
        self.master = master
        self.pack()
        self.create_widgets()

    def create_widgets(self):
        self.room_treeview = ttk.Treeview(self, columns=(
            "room_no", "room_type", "price"), selectmode="extended")
        self.room_treeview.heading("#0", text="Serial No.")
        self.room_treeview.heading("room_no", text="Room No.")
        self.room_treeview.heading("room_type", text="Room Type")
        self.room_treeview.heading("price", text="Price")
        room_data = self.get_room_data()
        for i, room in enumerate(room_data):
            self.room_treeview.insert("", "end", text=str(
                i+1), values=(room[0], room[1], room[2]))
        self.room_treeview.column("#0", width=80)
        self.room_treeview.column("room_no", width=100)
        self.room_treeview.column("room_type", width=100)
        self.room_treeview.column("price", width=100)
        self.room_treeview.pack(padx=10, pady=1)

        self.customer_name_label = tk.Label(self, text="Enter customer name:")
        self.customer_name_label.pack(pady=10)

        self.customer_name_entry = tk.Entry(self)
        self.customer_name_entry.pack()

        self.recommended_names_label = tk.Label(
            self, text="Recommended names:")
        self.recommended_names_label.pack()

        self.recommended_names_listbox = tk.Listbox(self)
        self.recommended_names_listbox.pack()

        self.check_in_label = tk.Label(self, text="Check-in date:")
        self.check_in_date = DateEntry(
            self, width=12, background='darkblue', foreground='white', borderwidth=2,selectmode="day")

        self.check_out_label = tk.Label(self, text="Check-out date:")
        self.check_out_date = DateEntry(
            self, width=12, background='darkblue', foreground='white', borderwidth=2,selectmode="day")

        self.check_in_label.pack(padx=10)
        self.check_in_date.pack(padx=10)
        self.check_out_label.pack(padx=10)
        self.check_out_date.pack(padx=10)

        self.button_frame = tk.Frame(self)
        self.button_frame.pack(pady=10, side="bottom")

        self.select_button = tk.Button(
            self.button_frame, text="Book", command=self.select_rooms)
        self.select_button.pack(side="left", padx=10)

        self.quit_button = tk.Button(
            self.button_frame, text="Quit", command=self.master.destroy)
        self.quit_button.pack(side="left", padx=10)

        self.customer_name_entry.bind("<KeyRelease>", self.recommend_names)
        self.recommended_names_listbox.bind(
            "<<ListboxSelect>>", self.select_recommended_name)

    def select_rooms(self):
        selected_rooms = []
        for room_id in self.room_treeview.selection():
            room = self.room_treeview.item(room_id)['values'][0]
            selected_rooms.append(room)
        customer_name = self.customer_name_entry.get()
        customer_id = customer_name.split(" ")[-1].strip("()")
        check_in_date = self.check_in_date.get_date()
        check_out_date = self.check_out_date.get_date()
        print(check_in_date)
        print(check_out_date)
        room_str = ''
        for room in selected_rooms:
            room_str += '('+str(room)+'),'
        room_str = room_str[:-1]
        print(room_str)
        executeProc(customer_id, room_str, check_in_date,
                    check_out_date, procName="book_rooms")
        self.master.destroy()
        tk.messagebox.showinfo(
            "Success!", f"Rooms {room_str} booked for {customer_name} from {check_in_date} to {check_out_date}.")

    def get_room_data(self):
        return execute("get_avail_room_data.sql", getInfo=True)

    def recommend_names(self, event):
        self.recommended_names_listbox.delete(0, tk.END)
        search_term = self.customer_name_entry.get()
        if search_term:
            recommended_names = [name for name, id in self.get_customer_names(
            ) if search_term.lower() in name.lower()]
            for name in recommended_names:
                self.recommended_names_listbox.insert(tk.END, name)

    def get_customer_names(self):
        return [(f"{r[1]} ({r[0]})", r[0]) for r in execute("get_guest_names.sql", getInfo=True)]

    def select_recommended_name(self, event):
        self.customer_name_entry.delete(0, tk.END)
        self.customer_name_entry.insert(0, self.recommended_names_listbox.get(
            self.recommended_names_listbox.curselection()))
