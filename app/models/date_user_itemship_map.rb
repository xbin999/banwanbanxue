class DateUserItemshipMap
  attr_reader :hash_day_item, :hash_item_day
  attr_reader :hash_day_value, :hash_item_title_value
  attr_reader :sum

  def initialize(user, user_items, records)
    @user = user
    @user_items = user_items
    @records = records

    @hash_day_item = Hash.new { |h,k| h[k] = {} } # created -> item_id -> value
    @hash_item_day = Hash.new { |h,k| h[k] = {} } # item_id -> created -> value
    @hash_day_value = Hash.new { |h,k| h[k] = 0 } # created -> value
    @hash_item_title_value = Hash.new { |h,k| h[k] = 0 } # item_title -> value, for graph
    @sum = 0
    @records.each do |record|
      if @hash_day_item[record.created][record.item_id].nil?
        @hash_day_item[record.created][record.item_id] = record.value
      else
        @hash_day_item[record.created][record.item_id] += record.value
      end
      if @hash_item_day[record.item_id][record.created].nil?
        @hash_item_day[record.item_id][record.created] = record.value
      else
        @hash_item_day[record.item_id][record.created] += record.value
      end
      @hash_day_value[record.created] += record.value
      @hash_item_title_value[record.item.title] += record.value
      @sum += record.value
    end
  end

  def sum_by_item(item_title)
    return @hash_item_title_value[item_title]
  end

  def avg_by_item(item_title)
    return @hash_item_title_value[item_title] / @hash_day_item.count
  end

  def sum_by_day(day)
    return @hash_day_value[day]
  end

end