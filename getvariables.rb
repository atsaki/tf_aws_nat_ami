#!/usr/bin/env ruby

require 'aws-sdk'
require 'json'

regions = Aws::EC2::Client.new(region: 'us-east-1')
    .describe_regions.regions.map { |r| r.region_name }

data = {}
regions.each do |region|
    images = Aws::EC2::Client.new(region: region).describe_images(
        owners: ['amazon'],
        filters: [{ name: 'image-type', values: ['machine'] }]
    ).images.select { |image|
        !image.name.nil? && image.name.start_with?("amzn-ami-vpc-nat")
    }
    data.merge!(Hash[images.map {|i| ["#{region},#{i.name}", i.image_id]}])
end

puts JSON.pretty_generate({ 
    variable: {
        amis: {
            default: data
        }
    }
})
