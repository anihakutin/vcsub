class ProcessExistingImagesVariants < ActiveRecord::Migration[7.1]
  def up
    puts "Starting to process image variants..."
    
    Listing.find_each do |listing|
      next unless listing.images.attached?
      
      puts "Processing images for listing #{listing.id}..."
      
      listing.images.each do |image|
        begin
          # Process each variant
          [:thumb, :medium, :social].each do |variant_name|
            begin
              image.variant(variant_name).processed
              puts "  ✓ Processed #{variant_name} variant for image #{image.id}"
            rescue => e
              puts "  ✗ Failed to process #{variant_name} variant for image #{image.id}: #{e.message}"
              next # Continue to next variant
            end
          end
        rescue => e
          puts "  ✗ Failed to process image #{image.id}: #{e.message}"
          next # Continue to next image
        end
      end
    end
    
    puts "Finished processing image variants."
  end

  def down
    # No need to undo variant processing
  end
end
