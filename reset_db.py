import mysql.connector as mysql

cnz = mysql.connect(
        host="localhost",
        user="user",
        passwd="password",
    )
cnz.autocommit = True
cursor = cnz.cursor(buffered=True)
with open("sql queries/reset_db.sql", 'r') as sql_file:
    sql_script = sql_file.read()
cursor.execute(sql_script)
print("Database Factory Reset!")

