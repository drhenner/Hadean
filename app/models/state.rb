class State < ActiveRecord::Base
  belongs_to :country
  has_many   :addresses
  
  
  def abbreviation_name(append_name = "")
    ([abbreviation, name].join(" - ") + " #{append_name}").strip
  end

  def abbrev_and_name
    "#{abbreviation} - #{name}"
  end

  def self.form_selector
    find(:all, :order => 'country_id ASC, abbreviation ASC').collect { |state| [state.abbrev_and_name, state.id] }
  end
end
