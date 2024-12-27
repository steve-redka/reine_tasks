require 'rspec'
require 'words_break'

RSpec.describe WordsBreak do
  describe '.words_break' do
    it 'is true on empty line' do
      expect(WordsBreak.words_break('', [])).to be true
    end

    it 'is true on one word' do
      expect(WordsBreak.words_break('foo', ['foo'])).to be true
    end

    it 'is false on mismatch' do
      expect(WordsBreak.words_break('bar', ['foo'])).to be false
    end

    it 'matches multiple words' do
      expect(WordsBreak.words_break('двесотни', ['две', 'сотни', 'тысячи'])).to be true
    end

    it 'matches possibly overlapping words' do
      expect(WordsBreak.words_break('beef', ['be', 'bee', 'ef'])).to be true
    end

    it 'doesnt match overlapping words' do
      expect(WordsBreak.words_break('beef', ['bee', 'ef'])).to be false
    end
  end
end
