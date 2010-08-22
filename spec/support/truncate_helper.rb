module Hadean
  module TruncateHelper
    
    UNSEEDED_TABLES = ["users", "addresses", "user_roles"]
    
    def truncate_all
      tables = ActiveRecord::Base.connection.tables
      tables.each { |table| truncate table }
    end

    
    def trunctate_unseeded 
      UNSEEDED_TABLES.each { |table| truncate table }
    end
    
    def truncate table
      ActiveRecord::Base.connection.execute "TRUNCATE TABLE #{table}"
    end
  end
end