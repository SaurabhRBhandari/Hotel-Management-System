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
    filename='sql queries/'+filename
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
        data = cursor.fetchall()
        cursor.close()
        return data
    cursor.close()
    cnz.close()


def clear_frame(frame):
    for widgets in frame.winfo_children():
        widgets.destroy()
