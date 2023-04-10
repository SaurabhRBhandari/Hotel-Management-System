import tkinter as tk


class StaffIDPopup:
    def __init__(self, master):
        self.master = master
        self.staff_id = None

        self.label = tk.Label(master, text="Enter staff ID:")
        self.label.pack()

        self.entry = tk.Entry(master)
        self.entry.pack()

        self.submit_button = tk.Button(
            master, text="Submit", command=self.submit)
        self.submit_button.pack()

    def submit(self):
        self.staff_id = self.entry.get()
        self.master.destroy()
