module Members
  class RequestAccessWithSecretService < BaseService
    attr_accessor :source

    def initialize(source, current_user, secret = nil)
      @source = source
      @current_user = current_user
      @secret = secret
    end

    def execute
      raise Gitlab::Access::AccessDeniedError unless (can_request_access_with_secret?(source) && @secret == @source.secret)

      source.members.create(
        access_level: Gitlab::Access::DEVELOPER,
        user: current_user)
    end

    private

    def can_request_access_with_secret?(source)
      source && can?(current_user, :request_access_with_secret, source)
    end
  end
end
