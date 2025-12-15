-- Test table creation
CREATE TABLE test_books (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  author TEXT NOT NULL,
  year INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert test data
INSERT INTO test_books (title, author, year) VALUES
  ('ვეფხისტყაოსანი', 'შოთა რუსთაველი', 1189),
  ('მერანი', 'ნიკოლოზ ბარათაშვილი', 1842),
  ('სურამის ციხე', 'დანიელ ჭონქაძე', 1860),
  ('კაცია-ადამიანი', 'ილია ჭავჭავაძე', 1863),
  ('დათა თუთაშხია', 'ჩაბუა ამირეჯიბი', 1975);