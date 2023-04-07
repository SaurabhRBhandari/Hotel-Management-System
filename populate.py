import mysql.connector as mysql
cnz=mysql.connect(host="localhost",user="user",passwd="password")
cursor=cnz.cursor(buffered=True)
cursor.execute("USE hoteldb")
with open("populate_data.sql", 'r') as sql_file:
    sql_script = sql_file.read()
cursor.execute(sql_script)
cnz.commit()