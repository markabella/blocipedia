module WikisHelper
 def user_is_authorized_to_view_wiki?(wiki)
  (wiki.private && (wiki.user == current_user)) || !wiki.private || current_user.admin?
 end
end
