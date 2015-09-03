# gem 'minitest', '~> 5.2'
# require 'minitest/autorun'
# require 'minitest/pride'
require 'chisel'

class ChiselTest < MiniTest::Test
  def test_it_works
    chisel = Chisel.new("")
    assert_equal "", chisel.parse
  end

  def test_it_gives_letters
    chisel = Chisel.new("a")
    assert_equal "a", chisel.parse
  end

  def test_header_one
    chisel = Chisel.new("line")
    assert_equal "line", chisel.parse
  end

  def test_it_has_paragraphs
    chisel = Chisel.new("test this is a line please")
    assert_equal "test this is a line please", chisel.parse
  end

  def test_it_takes_periods
    chisel = Chisel.new(".")
    assert_equal ".", chisel.parse
  end

  # def test_it_takes_fixnum
  #   chisel = Chisel.new(9)
  #   assert_equal "9", chisel.parse
  # end

  def test_header_one
    chisel = Chisel.new("# ")
    assert_equal "<h1></h1>", chisel.parse
  end

  def test_words_between_n
    chisel = Chisel.new("hello\n")
    assert_equal "<p>hello</p>", chisel.parse
  end

  # def test_two_words_between_n
  #   chisel = Chisel.new("hello\nbig\n")
  #   assert_equal ["hello", "big"], chisel.parse
  # end

  def test_starts_with_one_hash
    chisel = Chisel.new("# ")
    assert_equal "<h1></h1>", chisel.parse
  end

  def test_header_with_string
    chisel = Chisel.new("# string")
    assert_equal("<h1>string</h1>", chisel.parse)
  end

  def test_count_hashtag
   chisel = Chisel.new ('## string')
   assert_equal("<h2>string</h2>", chisel.parse)
  end

  def test_something_crazy
    chisel = Chisel.new ("hola amigos\n\n")
    assert_equal("<p>hola amigos</p>", chisel.parse)
  end

  def test_starts_with_one_hash_without_space
    chisel = Chisel.new("#")
    assert_equal "<h1></h1>", chisel.parse
  end

  def  test_starts_with_two_hash_without_space
   chisel = Chisel.new ('##string')
   assert_equal("<h2>string</h2>", chisel.parse)
  end

  def test_a_line_in_a_paragraph
    chisel = Chisel.new ("This is the first line of the paragraph.\n")
    assert_equal("<p>This is the first line of the paragraph.</p>", chisel.parse)
  end

  def test_two_lines_in_a_paragraph
    chisel = Chisel.new ("This is the first line of the paragraph.\nThis is the second line of the same paragraph.\n\n")
    assert_equal("<p>This is the first line of the paragraph.This is the second line of the same paragraph.</p>", chisel.parse)
  end

  def test_two_lines_in_a_paragraph_end_of_input
    skip
    chisel = Chisel.new ("This is the first line of the paragraph.\nThis is the second line of the same paragraph.")
    assert_equal("<p>This is the first line of the paragraph.This is the second line of the same paragraph.</p>", chisel.parse)
  end
end
