require "mysql2"

client = Mysql2::Client.new(host: "localhost", username: "username", password: "password", :encoding => "utf8", database: "dbname")

clear_table =  "DROP TABLE IF EXISTS language;"

ctb_lang = <<-SQL 
        CREATE TABLE language (
        id int AUTO_INCREMENT,
        name VARCHAR(10),
        type VARCHAR(10),
        author VARCHAR(20),
        PRIMARY KEY(id)
    );    
SQL

inst_lang = <<-SQL 
    INSERT INTO language
    (name, type, author)
    VALUES 
    ("Ruby", "dynamic", "Yukihiro Matsumoto"),
    ("PHP", "dynamic", "Rasmus Lerdorf"),
    ("Python", "dynamic", "Guido Van Rossum"),
    ("Go", "static", "Robert Griesemer"),
    ("Elixir", "static", "José Valim");
SQL

client.query(clear_table)
client.query(ctb_lang)
client.query(inst_lang)

results = client.query("SELECT * FROM language")

results.each do |result|
    puts result
end
