# $Id: transforms.rb 2521 2006-04-07 04:57:17Z keegan $
#
# Borrowing from Typo.

class String
  # Returns a-string-with-dashes when passed 'a string with dashes'.
  # All special chars are stripped in the process  
  def to_url
    return if self.nil?
    
    self.downcase.tr("\"'", '').gsub(/\W/, ' ').strip.tr_s(' ', '-').tr(' ', '-'
)
  end
end

Ratings = {
  -1 => 'Negative',
  0 => 'Neutral',
  1 => 'Positive'
}
