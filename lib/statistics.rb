class Statistics
  def sum(numbers)
    total = numbers.inject(0.0) { |result, number| result + number }

    BigDecimal.new(total, 4)
  end

  def mean(numbers)
    sum(numbers) / numbers.size
  end
end
