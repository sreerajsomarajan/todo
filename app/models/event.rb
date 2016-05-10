#
# Model Event
#
# @author [sreeraj s]
#
class Event < ActiveRecord::Base
  validates_uniqueness_of :name
end
