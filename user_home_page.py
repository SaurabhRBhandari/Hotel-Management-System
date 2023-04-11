import tkinter as tk
from PIL import ImageTk, Image
from guest_window import *
from utils import *
from staff_window import *
from orders_window import *
from room_window import *
from reserve_window import *
from bill_window import *

class HomePageScreen(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Home Page")
        self.geometry("1080x500")
        self.minsize(1080, 550)
        self.maxsize(1080, 550)
        self.create_widgets()
        self.reserve()

    def create_widgets(self):
        sep = tk.Frame(height=500, bd=1, relief='sunken', bg='white')
        # Create the top frame
        self.top_Frame = tk.Frame(self, height=70, width=1080)
        tf_label = tk.Label(self.top_Frame, text="Hotel Management System",
                            font='msserif 33', fg='black', bg='gray89', height=70)
        self.top_Frame.place(x=0, y=0)
        tf_label.pack(anchor='center')
        self.top_Frame.pack_propagate(False)

        # create the menu bar
        self.menu_bar = tk.Frame(self, height=130, width=1080)
        self.menu_bar.place(x=0, y=76)

        img = ImageTk.PhotoImage(Image.open("images/Bookroom.png"))
        b1 = tk.Button(self.menu_bar, text='Reserve', image=img,
                       width=179, command=self.reserve)
        b1.image = img
        b1.place(x=0, y=0)

        img = ImageTk.PhotoImage(Image.open("images/guests.png"))
        b2 = tk.Button(self.menu_bar, text='Guest Info',
                       image=img, width=179, command=self.guest)
        b2.image = img
        b2.place(x=180, y=0)

        img = ImageTk.PhotoImage(Image.open("images/rooms.png"))
        b3 = tk.Button(self.menu_bar, text='Room Info',
                       image=img, width=179, command=self.room)
        b3.image = img
        b3.place(x=360, y=0)

        img = ImageTk.PhotoImage(Image.open("images/staff.png"))
        b4 = tk.Button(self.menu_bar, text='Staff Info',
                       image=img, width=179, command=self.staff)
        b4.image = img
        b4.place(x=540, y=0)

        img = ImageTk.PhotoImage(Image.open("images/orders.png"))
        b5 = tk.Button(self.menu_bar, text='Orders Info',
                       image=img, width=179, command=self.orders)
        b5.image = img
        b5.place(x=720, y=0)

        img = ImageTk.PhotoImage(Image.open("images/logout.png"))
        b6 = tk.Button(self.menu_bar, text='Generate Bill', image=img,
                       width=179, height=100, command=self.bill)
        b6.image = img
        b6.place(x=900, y=0)

        tk.Label(self.menu_bar, text='Reserve',
                 font='msserif 13', bg='white').place(x=35, y=106)
        tk.Label(self.menu_bar, text='Guest Info',
                 font='msserif 13', bg='white').place(x=248, y=106)
        tk.Label(self.menu_bar, text='Room Info',
                 font='msserif 13', bg='white').place(x=417, y=106)
        tk.Label(self.menu_bar, text='Orders Info',
                 font='msserif 13', bg='white').place(x=774, y=106)
        tk.Label(self.menu_bar, text='Staff Info',
                 font='msserif 13', bg='white').place(x=570, y=106)
        tk.Label(self.menu_bar, text='Bills', font='msserif 13',
                 bg='white').place(x=968, y=106)

        self.menu_bar.pack_propagate(False)

        self.bottom_Frame = tk.Frame(self, height=290, width=1080)
        self.bottom_Frame.place(x=0, y=210)

        self.bottom_Frame1 = tk.Frame(self, height=290, width=1080)
        self.bottom_Frame1.pack(side=tk.BOTTOM)

    def reserve(self):
        clear_frame(self.bottom_Frame)
        clear_frame(self.bottom_Frame1)
        Reserve(self.bottom_Frame, self.bottom_Frame1)

    def guest(self):
        clear_frame(self.bottom_Frame)
        clear_frame(self.bottom_Frame1)
        Guest(self.bottom_Frame, self.bottom_Frame1)

    def room(self):
        clear_frame(self.bottom_Frame)
        clear_frame(self.bottom_Frame1)
        Room(self.bottom_Frame, self.bottom_Frame1)

    def staff(self):
        clear_frame(self.bottom_Frame)
        clear_frame(self.bottom_Frame1)
        Staff(self.bottom_Frame, self.bottom_Frame1)

    def orders(self):
        clear_frame(self.bottom_Frame)
        clear_frame(self.bottom_Frame1)
        Orders(self.bottom_Frame, self.bottom_Frame1)
    
    def bill(self):
        clear_frame(self.bottom_Frame)
        clear_frame(self.bottom_Frame1)
        Bill(self.bottom_Frame, self.bottom_Frame1)

if __name__=='__main__':
    HomePageScreen().mainloop()