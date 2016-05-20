Enjoy.rails_admin_configure do |config|
  config.action_visible_for :nested_set, 'Enjoy::News::Category'

  if Enjoy::News.active_record?
    config.action_visible_for :nested_set, 'Enjoy::News::Image'
  elsif Enjoy::News.mongoid?
    config.action_visible_for :sort_embedded, 'Enjoy::News::News'
  end

  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Enjoy::News::News'
    config.action_visible_for :comments, 'Enjoy::News::Category'
    if Enjoy::News.active_record?
      config.action_visible_for :comments, 'Enjoy::News::Image'
    end
    config.action_visible_for :model_comments, 'Enjoy::News::News'
    config.action_visible_for :model_comments, 'Enjoy::News::Category'
    if Enjoy::News.active_record?
      config.action_visible_for :model_comments, 'Enjoy::News::Image'
    end
  end

  if defined?(RailsAdminMultipleFileUpload)
    if Enjoy::News.mongoid?
      config.action_visible_for :multiple_file_upload, 'Enjoy::News::News'
    end
  end
end

Enjoy.configure do |config|
  _actions = [:new, :edit, :update, :multiple_file_upload, :sort_embedded]
  if Enjoy::News.active_record?
    _actions.delete(:multiple_file_upload)
    _actions.delete(:sort_embedded)
  end
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::News::News,
    actions: _actions
  }

  _actions = [:new, :edit, :update, :nested_set, :multiple_file_upload, :sort_embedded]
  if Enjoy::News.active_record?
    _actions.delete(:multiple_file_upload)
    _actions.delete(:sort_embedded)
  end
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::News::Category,
    actions: _actions
  }
  if Enjoy::Catalog.active_record?
    config.ability_manager_config << {
      method: :can,
      model: Enjoy::News::Image,
      actions: _actions
    }
  end
end

if defined?(RailsAdmin)
  RailsAdmin.config do |config|
    config.excluded_models ||= []
    if Enjoy::News.mongoid?
      config.excluded_models << [
        'Enjoy::News::Image'
      ]
    end
    config.excluded_models.flatten!
  end
end
