import sys, os
# import config from subdirectory `function`
currentdir = os.path.dirname(os.path.realpath(__file__))
parentdir = os.path.dirname(currentdir)
sys.path.append(parentdir)
from function import config

import pandas as pd
# pip install mysql-connector-python
# pip install pymysql
# pip install sqlalchemy
import mysql.connector as mc
from mysql.connector import errorcode
from sqlalchemy import create_engine 

input_file = os.path.join("redesign", "passengers.csv")
df = pd.read_csv(input_file)
# insert passenger_id to df
n_row = df.shape[0]
df.insert(0, "passenger_id", range(1, n_row+1))
#print(df[0:2])

# make sqlalchemy.engine
db = config.sqlalchemy_engine("flight2")

# transaction
if db is not None:
    #insert, three modes:fail,replace,append. index to False, skip row index
    df.to_sql('passenger', con=db, if_exists='append', index=False) 
    #airlines_df.to_csv(f, index=False, line_terminator='\n')
    test = pd.read_sql("select * from passenger", db)
    print(test[0:5])
    #close connection
    db.close()  
else:
    print(f"No connection available.")

# close connection
db.close()    
