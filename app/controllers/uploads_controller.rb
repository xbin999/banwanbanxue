# encoding: utf-8

class UploadsController < ApplicationController
  def index
  end

  def upload
    file_data = params[:record_file][:csv]
    if file_data.respond_to?(:read)
      xml_contents = file_data.read
    elsif file_data.respond_to?(:path)
      xml_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end

    sep = ','
    items = {}
    Item.all.each do |item|
      items[item.title] = item.id
      logger.debug "#{item.title} => #{items[item.title]}"
    end
    
    xml_contents.each_line do |line|
      arr = line.split(sep)
      logger.debug "#{arr[0]},#{arr[1]},#{items[arr[1]]},#{arr[2]}"
      rec = Record.create(created: arr[0], item_id: items[arr[1].force_encoding("UTF-8")], value: arr[2].to_f, user_id: current_user.id)
      rec.save
    end

    flash[:success] = "#{file_data.original_filename}上传成功"
    redirect_to tool_path
  end
end
