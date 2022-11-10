class BaseService

  def user_has_permissions?(user, permission)
    if user && (user.role_permissions[permission] || user.full_access)
      true
    else
      raise "user not has permissions"
    end
  end

  def user_owns_item?(user, item)
    user && item && item.send(user.class.name.downcase + '_id') == user.id
  end
end