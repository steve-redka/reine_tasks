class WordsBreak
  def self.words_break(s, words)
    # pattern = Regexp.new("^(#{words.join('|')})+$")
    # !!(str =~ pattern)
    dp = Array.new(s.length + 1, false)
    dp[0] = true

    (1..s.length).each do |i|
      (0...i).each do |j|
        p dp
        p s[j...i]
        if dp[j] && words.include?(s[j...i])
          dp[i] = true
          break
        end
      end
    end

    dp[s.length]
  end
end
