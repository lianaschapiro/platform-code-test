require 'award'

def decrease_quality(award)
  if award.quality > 0
    award.quality -= 1
  end
end

def increase_quality(award)
  if award.quality < 50
    award.quality += 1
  end
end

def update_quality(awards)
  awards.each do | award |
    # Blue Distinction Plus values never change
    if award.name != 'Blue Distinction Plus'
      # All other awards (except Blue First and Blue Compare) decrease in quality each day
      if award.name != 'Blue First' && award.name != 'Blue Compare'
        decrease_quality(award)
        # Blue Star awards decrease an extra quality point each day
        if award.name == 'Blue Star'
          decrease_quality(award)
        end
      else
        # Blue First and Blue Compare increase in quality over time
        if award.quality < 50
          award.quality += 1
          if award.name == 'Blue Compare'
            if award.expires_in < 11
              increase_quality(award)
              if award.expires_in < 6
                increase_quality(award)
              end
            end
          end
        end
      end
      # decrease days until award expiration
      award.expires_in -= 1
      if award.expires_in < 0
        # after expiration, awards decrease yet another point (except Blue First and Blue Compare)
        if award.name != 'Blue First'
          if award.name != 'Blue Compare'
            decrease_quality(award)
            # Blue Star awards decrease yet another point (for a total of 4) after expiration
            if award.name == 'Blue Star'
              decrease_quality(award)
            end
          # Blue Compare quality drops to 0 after expiration
          else
            award.quality = 0
          end
        # Blue First increases extra quality point after expiration
        else
          increase_quality(award)
        end
      end
    end
  end
end
