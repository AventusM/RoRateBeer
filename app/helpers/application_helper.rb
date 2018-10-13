module ApplicationHelper
  def edit_button_if_current_user(item)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit], item, class: 'btn btn-link btn-sm'))
      raw('#{edit}')
    end
  end

  def destroy_button_if_current_user(item)
    unless current_user.nil?
      del = link_to('Destroy', item, method: :delete, data: {confirm: 'Are you sure?'}, class: 'btn btn-danger btn-link btn-sm')
      raw('#{del}')
    end
  end

  def round(average)
    number_with_precision(average, precision: 1)
  end
end
