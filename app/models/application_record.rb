# This class is parent to all models in the application.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
