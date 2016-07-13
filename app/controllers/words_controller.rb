require 'nokogiri'
require 'open-uri'

class WordsController < ApplicationController
  def index
  end

  def translate
    @source = params[:source][:name]
    logger.debug "translate #{@source}..."
    @target = Hash.new
    @source.split(" ").each do |word|
      @target[word] = convert(word)
    end
    #render :json => @target.to_json
    #render 'translate'
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "words",
               :template => 'words/translate.html.haml',
               :layout => "pdf.html.haml"
      end
    end
  end

private
  def convert(source)
    target ||= []
    doc = Nokogiri::HTML(open("http://youdao.com/w/eng/#{source}/#keyfrom=dict2.index"))
    doc.css("div#phrsListTab.trans-wrapper.clearfix li").each do |link|
      logger.debug "#{link.content}"
      target << link.content
    end
    return target
  end

end
