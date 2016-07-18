require 'nokogiri'
require 'open-uri'
require 'json'
require 'bing_translator'

class WordsController < ApplicationController
  def index
    #logger.debug "http://fanyi.youdao.com/openapi.do?keyfrom=#{Rails.configuration.mysecrets['keyfrom']}&key=#{Rails.configuration.mysecrets['key']}&type=data&doctype=json&version=1.1&q=hello"
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
  def convert4youdao(source)
    target ||= []
    doc = Nokogiri::HTML(open("http://youdao.com/w/eng/#{source}"))
    doc.css("div#phrsListTab.trans-wrapper.clearfix li").each do |link|
      logger.debug "===> translate to #{link.content}"
      target << link.content
    end
    return target
  end

  def convert4bing(source)
    target ||= []
    if @translator == nil
      @translator = BingTranslator.new(Rails.configuration.mysecrets['bing_id'], Rails.configuration.mysecrets['bing_secret'])
    end
    chinese = @translator.translate(source, :from => 'en', :to => 'zh-CHS')
    logger.debug "===> translate to #{chinese}"
    target << chinese
    return target
  end

  def convert(source)
    target ||= []
    # http://fanyi.youdao.com/openapi.do?keyfrom=XXXXXX&key=XXXXXXXX&type=data&doctype=json&version=1.1&q=hello
    doc = JSON.parse(open("http://fanyi.youdao.com/openapi.do?keyfrom=#{Rails.configuration.mysecrets['keyfrom']}&key=#{Rails.configuration.mysecrets['key']}&type=data&doctype=json&version=1.1&q=#{source}").read)
    if doc.fetch('basic',{}).fetch('explains',nil) != nil
      target << "us: [#{doc['basic']['us-phonetic']}]  uk: [#{doc['basic']['uk-phonetic']}]"
      doc['basic']['explains'].each do |link|
        logger.debug "---> translate to #{link}"
        target << link
      end
    end

    return target
  end

end
