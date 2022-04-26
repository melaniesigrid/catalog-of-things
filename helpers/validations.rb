require 'date'

module Validations
  def validates_date
    begin
      date = gets.chomp
      date = Date.parse(date)
    rescue ArgumentError
      print 'Please enter date in the format YYYY/MM/DD: '
      retry
    end
    date
  end
end
