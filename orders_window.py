import tkinter as tk
from tkinter import ttk
from utils import *
from new_service_form import *
from new_order_form import *


class Orders():
    def __init__(self, frame, frame1):
        super().__init__()
        self.frame = frame
        self.frame1 = frame1
        self.create_widgets()

    def create_widgets(self):
        self.table = ttk.Treeview(self.frame, columns=(
            "service_id", "name", "quantity", "room_no", "total_cost"), show="headings")
        self.table.heading("service_id", text="Service ID", command=lambda: treeview_sort_column(self.table, "service_id", False))
        self.table.heading("name", text="Name", command=lambda: treeview_sort_column(self.table, "name", False))
        self.table.heading("quantity", text="Qt.", command=lambda: treeview_sort_column(self.table, "quantity", False))
        self.table.heading("room_no", text="Room No.", command=lambda: treeview_sort_column(self.table, "room_no", False))
        self.table.heading("total_cost", text="Total Cost", command=lambda: treeview_sort_column(self.table, "total_cost", False))
        scrollbar = ttk.Scrollbar(
            self.frame, orient="vertical", command=self.table.yview)
        self.table.configure(yscrollcommand=scrollbar.set)
        data = self.get_service_data()
        for i in data:
            self.table.insert("", tk.END, values=i)
        self.table.pack(side=tk.TOP, fill='both', expand=True,
                        padx=20, pady=20, anchor=tk.CENTER)
        # b1=tk.Button(self.frame1,text='Add Service',width=10,command=self.add)
        # b2=tk.Button(self.frame1,text='Update Service',width=10,command=self.update)
        # b3=tk.Button(self.frame1,text='Delete Service',width=10,command=self.delete)
        b4 = tk.Button(self.frame1, text='New Order',
                       width=10, command=self.order)
        b5 = tk.Button(self.frame1, text='Refresh',
                       width=10, command=self.refresh)
        # b1.grid(row=0,column=0,padx=10)
        # b2.grid(row=0,column=1,padx=10)
        # b3.grid(row=0,column=2,padx=10)
        b4.grid(row=0, column=0, padx=10)
        b5.grid(row=0, column=1, padx=10)

    def get_service_data(self):
        return execute("fetch_service_info.sql", True)

    def add(self):
        # TODO
        print("Add Sevice")
        # root = tk.Tk()
        # root.title("Add New Service")
        # form = NewServiceForm(root)
        # form.pack()
        # root.mainloop()

    def update(self):
        # TODO
        print("Update Service")
        # selectedItems=self.table.selection()
        # if(len(selectedItems)!=1):
        #     label=tk.Label(self.frame,text="Please select a single row to delete",fg="red")
        #     label.pack()
        #     return
        # id=self.table.item(selectedItems[0],"values")[0]
        # root = tk.Tk()
        # root.title("Update Guest")
        # form = UpdateCustomerForm(root,id,self.table.item(selectedItems[0],"values")[1:])
        # form.pack()
        # root.mainloop()

    def delete(self):
        # TODO
        print("Delete Service")
        # selectedItems=self.table.selection()
        # if(len(selectedItems)==0):
        #     label=tk.Label(self.frame,text="Please select a row to delete",fg="red")
        #     label.pack()
        #     return
        # for item in selectedItems:
        #     executeProc(self.table.item(item,"values")[0],procName="delete_guest")
        # clear_frame(self.frame)
        # clear_frame(self.frame1)
        # Guest(self.frame,self.frame1)

    def order(self):
        root = tk.Tk()
        root.title("New Order")
        form = NewOrderForm(root)
        form.pack()
        root.mainloop()

    def refresh(self):
        clear_frame(self.frame)
        clear_frame(self.frame1)
        Orders(self.frame, self.frame1)
