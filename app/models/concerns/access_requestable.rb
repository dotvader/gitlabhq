# == AccessRequestable concern
#
# Contains functionality related to objects that can receive request for access.
#
# Used by Project, and Group.
#
module AccessRequestable
  extend ActiveSupport::Concern

  def request_access(user)
    Members::RequestAccessService.new(self, user).execute
  end

  def request_access_with_secret(user, secret)
    Members::RequestAccessWithSecretService.new(self, user, secret).execute
  end
end
