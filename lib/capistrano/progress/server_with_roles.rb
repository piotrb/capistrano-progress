require 'delegate'
class ServerWithRoles < SimpleDelegator

  def initialize(server, roles)
    @roles = roles
    super(server)
  end

  def roles
    @roles
  end

  def roles_string
    @roles.map { |i| i.to_s }.join(', ')
  end

end
