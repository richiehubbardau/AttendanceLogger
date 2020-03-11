require 'sequel'

def initialize_database
  File.file?('../database.db') ? (return Sequel.connect('sqlite://../database.db')) : (return create_database)
end

def create_database
  db = Sequel.connect('sqlite://../database.db')

  # Here we are creating the table for our Users

  db.create_table :users do
    primary_key :id
    String :name
    String :role
    String :password
    String :email
  end

  # Creating Table Structure For the Attendance Log

  db.create_table :logs do
    primary_key :id
    Boolean :approved
    Boolean :overwrite
    DateTime :sign_in_dateTime
    DateTime :sign_out_dateTime
  end

end

def find_user(id)
  return db[:users].first(:id => id)
end