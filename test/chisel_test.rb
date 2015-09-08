require 'chisel_parser'

class ChiselTest < MiniTest::Test
  meta current:true
  def test_it_works
    chisel = Chisel.new("")
    assert_equal "", chisel.parse
  end

  def test_it_gives_letters
    chisel = Chisel.new("a")
    assert_equal "<p>a</p>", chisel.parse
  end

  def test_header_one
    chisel = Chisel.new("line")
    assert_equal "<p>line</p>", chisel.parse
  end

  def test_it_has_paragraphs
    chisel = Chisel.new("test this is a line please")
    assert_equal "<p>test this is a line please</p>", chisel.parse
  end

  def test_it_takes_periods
    chisel = Chisel.new(".")
    assert_equal "<p>.</p>", chisel.parse
  end

  def test_header_one
    chisel = Chisel.new("# ")
    assert_equal "<h1></h1>", chisel.parse
  end

  def test_words_between_n
    chisel = Chisel.new("hello\n")
    assert_equal "<p>hello</p>", chisel.parse
  end

  def test_two_words_between_n
    chisel = Chisel.new("hello\n big\n")
    assert_equal "<p>hello big</p>", chisel.parse
  end

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
    chisel = Chisel.new ("This is the first line of the paragraph.\nThis is the second line of the same paragraph.")
    assert_equal("<p>This is the first line of the paragraph.This is the second line of the same paragraph.</p>", chisel.parse)
  end

  def test_complete_paragraph
    chisel = Chisel.new ("This is the first line of the first paragraph.\n\nThis is the first line of the second paragraph.\n")
    assert_equal("<p>This is the first line of the first paragraph.</p><p>This is the first line of the second paragraph.</p>", chisel.parse)
  end

  def test_double_header
    chisel = Chisel.new ("# My Life in Desserts\n## Chapter 1: The Beginning")
    assert_equal("<h1>My Life in Desserts</h1><h2>Chapter 1: The Beginning</h2>", chisel.parse)
  end

  def test_italicize_one_dot
    chisel = Chisel.new ("*hola*")
    assert_equal("<p><em>hola</em></p>", chisel.parse)
  end

  def test_does_it_bold
    chisel = Chisel.new("**bold**")
    assert_equal("<p><strong>bold</strong></p>", chisel.parse)
  end

  def test_it_bolds_and_italicizes
    chisel = Chisel.new("My *emphasized and **stronged** text* is awesome")
    assert_equal("<p>My <em>emphasized and <strong>stronged</strong> text</em> is awesome</p>", chisel.parse)
  end

  def test_it_takes_unordered_lists
    chisel = Chisel.new("* Sushi\n")
    assert_equal("<ul><li> Sushi</li></ul>", chisel.parse)
  end

  def test_it_can_do_multiple_unordered_lists
    chisel = Chisel.new("* Sushi\n* Love\n")
    assert_equal("<ul><li> Sushi</li><li> Love</li></ul>", chisel.parse)
  end

  def test_it_can_do_single_ordered_lists
    chisel = Chisel.new("1. Sushi\n")
    assert_equal("<ol><li> Sushi</li></ol>", chisel.parse)
  end

  def test_it_can_do_multiple_ordered_lists
    chisel = Chisel.new("1. Sushi\n2. Love\n")
    assert_equal("<ol><li> Sushi</li><li> Love</li></ol>", chisel.parse)
  end

end
