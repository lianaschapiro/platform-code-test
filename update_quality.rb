require './award.rb'

def update_quality(awards)
  awards.each do |award|
    # Blue Distinction Plus values never change
    if award.name != 'Blue Distinction Plus'
      # All other awards decrease in quality except Blue First and Blue Compare
      if award.name != 'Blue First' && award.name != 'Blue Compare'
        if award.quality > 0
          award.quality -= 1
        end
      else
        # Blue First and Blue Compare increase in quality
        if award.quality < 50
          award.quality += 1
          if award.name == 'Blue Compare'
            if award.expires_in < 11
              if award.quality < 50
                award.quality += 1
              end
            end
            if award.expires_in < 6
              if award.quality < 50
                award.quality += 1
              end
            end
          end
        end
      end
      award.expires_in -= 1
      if award.expires_in < 0
        if award.name != 'Blue First'
          if award.name != 'Blue Compare'
            if award.quality > 0
              # after expiration, awards decrease yet another point (except Blue First and Blue Compare)
              award.quality -= 1
            end
          # Blue Compare quality drops to 0 after expiration
          else
            award.quality = 0
          end
        # Blue First increases extra quality point after expiration
        else
          if award.quality < 50
            award.quality += 1
          end
        end
      end
    end
  end
end
