class Record < ActiveRecord::Base

    def formatted_value
      begin
        special_class = (klass.capitalize + 'Formatter').constantize
        special_class.format(value)
      rescue
        value
      end
    end

end
