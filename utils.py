import mysql.connector as mysql
import tkinter as tk


def execute(filename, getInfo=False):
    cnz = mysql.connect(
        host="localhost",
        user="user",
        passwd="password",
    )
    filename='sql queries/'+filename
    cnz.autocommit = True
    cursor = cnz.cursor(buffered=True)
    cursor.execute("USE hoteldb")
    with open(filename, 'r') as sql_file:
        sql_script = sql_file.read()
    cursor.execute(sql_script)

    if (getInfo):
        data = cursor.fetchall()
        cursor.close()
        return data
    cursor.close()
    cnz.close()


def executeProc(*args, procName, getInfo=False):
    cnz = mysql.connect(
        host="localhost",
        user="user",
        passwd="password",
    )
    cnz.autocommit = True
    cursor = cnz.cursor(buffered=True)
    cursor.execute("USE hoteldb;")
    cursor.callproc(procName, args)
    if (getInfo):
        data=[]
        for result in cursor.stored_results():
            data.append(result.fetchall())
        return data
    cursor.close()
    cnz.close()

def treeview_sort_column(tv, col, reverse):
    try:
        l = [(int(tv.set(k, col)), k) for k in tv.get_children('')]
    except ValueError:
        l = [(tv.set(k, col), k) for k in tv.get_children('')]
    l.sort(reverse=reverse)

    # rearrange items in sorted positions
    for index, (val, k) in enumerate(l):
        tv.move(k, '', index)

    # reverse sort next time
    tv.heading(col, command=lambda: \
               treeview_sort_column(tv, col, not reverse))


def clear_frame(frame):
    for widgets in frame.winfo_children():
        widgets.destroy()
