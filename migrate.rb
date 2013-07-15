require "CSV"
require "sqlite3"

if ARGV[0].to_s=='' || ARGV[1].to_s==''
	p "Usage: migrate.rb csvfile dbfile"
	exit
end

db = SQLite3::Database.new ARGV[1]

CSV.foreach(ARGV[0]) do |row|
	source = row[0] + row[1] unless row[0]==nil
	q = row[2]
	a = row[3]
	ref = row[4]
	db.execute("INSERT INTO questions(question, answer, reference, source) values (?,?,?,?)", q, a, ref, source)

end
