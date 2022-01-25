

#convention, all input card number is string, which only contains numbers.

def creditcard_valid?(card_number)
  luhn_checksum(card_number) == 0
end

def append_check_digit_to_card(partial_card_number)
  check_digit = luhn_checksum(partial_card_number)
  check_digit = 10  - check_digit if check_digit != 0
  "#{partial_card_number}#{check_digit}"
end

def luhn_checksum(card_number)
  digit_vec = card_number.split('').map(&:to_i)
  sum_of_digit = 0
  digit_vec.each_with_index do |digit, index|
    digit *= 2 if (index+1) % 2 == 0
    if digit > 10
      sum_of_digit += (digit/10 + digit % 10)
    else
      sum_of_digit += digit
    end
  end
  sum_of_digit % 10
end

