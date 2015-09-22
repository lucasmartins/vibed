#!/usr/bin/env ruby
# author: Lucas Neves Martins
# email: lucasmartins@railsnapraia.com
# VibeDownloader

require 'json'
require 'thor'
require 'open-uri'
require 'uri'
# require 'pry'

class Vibed < Thor
  map "-v" => :version

  VERSION='0.0.1'
  CONFIG_FILE="#{ENV['HOME']}/.config/vibed"

  desc 'version','Shows the version'
  def version
    puts "#{VERSION}\n"
  end

  desc 'start','Search & Download a music file.'
  def start
    load_config
    cookie = cache_cookie
    while true
      search_and_download(cookie)
    end
  end

  private

  def search_and_download(cookie)
    puts "Tell me the music name and author:\n"
    search_param = STDIN.gets.chomp.gsub(' ','_')
    
    # puts "Params: #{search_param}"
    target_file = "#{@config['download_folder']}/#{search_param}.mp3"
    search_link = "http://vibeclouds.net/tracks/#{search_param}.html"
    # puts "Search link: #{search_link}"

    page_content = open(search_link, "Cookie" => cookie.meta['set-cookie'].split('; ',2)[0]).read
    results = page_content.scan(/location\.href='(.*)'/)

    download_link = select_download_link(results)
    download_file_to_target(download_link, target_file, cookie)
  end

  def cache_cookie
    puts "Getting cookie..."
    cookie_ref = open("http://vibeclouds.net")
    puts "OHM NOM NOM..."
    cookie_ref
  end

  def download_file_to_target(download_link, target_file, cookie)
    File.delete(target_file) if File.exist?(target_file)
    f=File.new(target_file,'w')
    puts "Downloading #{download_link} into #{target_file}"
    open(download_link, "Cookie" => cookie.meta['set-cookie'].split('; ',2)[0]) do |uri|
      f.write(uri.read)
    end
    f.close
  end

  def select_download_link(results)
    unless results.empty?
      results.flatten!
      puts "Select the file:\n"
      results.each_with_index do |r, i|
        puts "[#{i}] #{r.match(/.*\/(.*)\./)[1].gsub('_', ' ')}"
      end
      option = STDIN.gets.chomp!.to_i
      download_link = URI.escape(results[option])
      return download_link
    else
      raise "No results for this search!"
    end
  end

  def load_config
    if File.exist? CONFIG_FILE
      @config = JSON.parse(File.read(CONFIG_FILE))
      unless @config.class==Hash
        raise 'Corrupt JSON file!'
      end
      return
    else
      @config={
        'download_folder'=>"#{ENV['HOME']}/Desktop"
      }
      save_config
    end
  end

  def save_config
    File.open(CONFIG_FILE, 'w') {|f| f.write(@config.to_json) }
  end

end

Vibed.start