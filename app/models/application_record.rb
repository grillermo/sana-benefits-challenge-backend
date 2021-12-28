class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def errors_message
    self.errors.full_messages.join(', ')
  end
end
