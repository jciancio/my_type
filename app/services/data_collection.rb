class DataCollection < Array

  class InvalidData < StandardError; end

  def initialize(arr)
    begin
      super(arr.map(&:to_f))
    rescue => e
      raise InvalidData.new(e)
    end
  end

  def sum
    inject(0) { |current_sum, i| current_sum + i }
  end

  def mean
    sum / length.to_f
  end

  def sample_variance
    m = mean
    sum = inject(0){ |current_sum, i| current_sum + (i-m) ** 2 }
    sum / (size - 1).to_f
  end

  def standard_deviation
    Math.sqrt(sample_variance)
  end

  def margin_of_error
    # at 99% confidence level
    z_score = 2.576
    z_score * standard_deviation / Math.sqrt(size)
  end

  def confidence_interval
    [mean + margin_of_error, mean - margin_of_error].to_data_collection
  end

  def remove_outliers
    conf_range = confidence_interval
    select { |n| n < conf_range[0] && n > conf_range[1] }.to_data_collection
  end

end
