#!/usr/bin/env ruby
# Encoding: utf-8
#
# Author:: sgomes@google.com (Sérgio Gomes)
#
# Copyright:: Copyright 2013, Google Inc. All Rights Reserved.
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.
#
# This example gets all URL channels in an ad client.
#
# To get ad clients, run get_all_ad_clients.rb.
#
# Tags: accounts.urlchannels.list

require_relative 'adsense_common'

# The maximum number of results to be returned in a page.
MAX_PAGE_SIZE = 50

def get_all_url_channels(adsense, account_id, ad_client_id)
  request = adsense.accounts.urlchannels.list(
      :accountId => account_id, :adClientId => ad_client_id,
      :maxResults => MAX_PAGE_SIZE)

  loop do
    result = request.execute

    result.data.items.each do |url_channel|
      puts 'URL channel with URL pattern "%s" was found.' %
        url_channel.urlPattern
    end

    break unless result.next_page_token
    request = result.next_page
  end
end


if __FILE__ == $0
  adsense = service_setup()

  unless ARGV.size == 2
    puts "Usage: #{$0} ACCOUNT_ID AD_CLIENT_ID"
    exit
  end

  account_id, ad_client_id = ARGV

  get_all_url_channels(adsense, account_id, ad_client_id)
end
